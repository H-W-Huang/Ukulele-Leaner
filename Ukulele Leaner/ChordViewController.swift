//
//  FirstViewController.swift
//  Ukulele Leaner
//
//  Created by HW on 17/2/11.
//  Copyright © 2017年 HW. All rights reserved.
//

import UIKit

class ChordViewController: UITableViewController,UISearchBarDelegate {


//    private var searchBarController:UISearchController!
//    var searchBar: UISearchBar!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive:Bool = false
    let chordSegueIndentity:String! = "ChordDetailSegue"
    
    var currentIndex = 0
    var chordTitles:[String] = ["C","Db","D","Eb","E","F","Gb","G","Ab","A","Bb","B"]
    var searchResult = [UkuleleChord]()  //暂存搜索结果

    var chordDics = [String:[UkuleleChord]]()
    
    
    
    required init?(coder aDecoder: NSCoder) {
//        let chordC = UkuleleChord(name: "C",note: "des",sound:"x")
//        let chordD = UkuleleChord(name: "D",note: "des",sound:"x")
//        chords.append(chordC)
//        chords.append(chordD)
        super.init(coder: aDecoder)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == chordSegueIndentity{
            if let detailViewController:ChordDetailViewController = segue.destination as? ChordDetailViewController{
                
                //还是要根据搜索状态来选择数据
                if(searchActive == false){
                    print("当前不在搜索")
                    let section = self.tableView.indexPathForSelectedRow?.section
                    let row = self.tableView.indexPathForSelectedRow?.row
                    //封装数据到UkuleleChord对象
                    let chordTitle = chordTitles[section!]
                    let ukuleleChord = chordDics[chordTitle]?[row!]
                    print("点击了"+(ukuleleChord?.name)!)
                    detailViewController.chord = ukuleleChord
                }else{
                    print("当前在搜索")
                    let row = self.tableView.indexPathForSelectedRow?.row
                    print("行数为: \(row)")
                    print("搜索结果为:\(searchResult)")
                    if( row! < searchResult.count ){
                        let ukuleleChord = searchResult[row!]
                        print("点击了"+ukuleleChord.name)
                        detailViewController.chord = ukuleleChord
                    }
                }
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
    
               
//        self.navigationItem.title = "Chord"
//        self.navigationItem.
        
        //初始化数据，从plist中读取数据
        loadDataFromFile()
        // searchBar 初始化
        searchBarInit()
        
    }
    
    
    //tableView相关
    //每个section数目中的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if(searchActive == false){
            count = self.chordDics[self.chordTitles[section]]!.count
        }else{
            count = self.searchResult.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChordItem", for: indexPath)
        
        let iconLabel = cell.viewWithTag(100) as! UILabel
        let longNameLabel = cell.viewWithTag(200) as! UILabel
        var chord:UkuleleChord = UkuleleChord()
        //根据搜索状态选择数据源
        if(searchActive == false){
            chord = self.chordDics[self.chordTitles[indexPath.section]]![indexPath.row]
        }else{
            chord = self.searchResult[indexPath.row]
        }
        
        iconLabel.text = chord.name
        longNameLabel.text = chord.note
        
        return cell
    }

    
    //section数目
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(searchActive == false){
            return self.chordTitles.count
        }else{
            return 1
        }
    }
    
    
    //section Header Title的内容
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(searchActive == false){
            return chordTitles[section]
        }else{
            return nil
        }
    }
    
    
    //section title 数组
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if(searchActive == false){
            return self.chordTitles
        }else{
            return nil
        }
    }
    
    
    //搜索功能

    /**
        搜索框初始化
    **/
    func searchBarInit(){
    
        searchBar.delegate = self
        
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if(searchText.isEmpty){
            searchActive = false
            searchResult.removeAll()
        }else{
            searchActive = true
            //开始查找数据
            for (_,chords) in chordDics{
                for chord in chords{
                    if chord.name.contains(searchText) {
                        searchResult.append(chord)  //搜集结果
                    }
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        print("在searchBarTextDidEndEditing()中，结果被清空")
//        searchResult.removeAll()
        print("searchBarTextDidEndEditing...")
        searchActive = false
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        print("在searchBarTextDidBeginEditing()中，结果被清空")
//        searchResult.removeAll()
        print("searchBarTextDidBeginEditing...")
        searchBar.showsCancelButton = true
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("在searchBarCancelButtonClicked()中，结果被清空")
        self.searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchActive = false
        searchResult.removeAll()
        searchBar.text = ""
        self.tableView.reloadData()
    }
    
    
    
    
    //数据初始化
    func loadDataFromFile(){
        // -----  尝试读取ChordList.plist -----
        print("尝试读取ChordList.plist")
        let path = Bundle.main.path(forResource: "ChordList.plist", ofType: nil)
        let chordTypeNum = chordTitles.count
        let chordCount = 9
        var ChordDictionary:NSDictionary?
        ChordDictionary = NSDictionary(contentsOfFile: path!)
        for i in 0..<chordTypeNum{
            let someChordListData = ChordDictionary?.value(forKey:chordTitles[i]) as! NSArray
            var someChordList = [UkuleleChord]()
            for j in 0 ..< chordCount{
                let someChordData = someChordListData[j] as! NSDictionary
                let name = someChordData.value(forKey: "name") as! String
                let note = someChordData.value(forKey: "note") as! String
                let someChord = UkuleleChord(name: name, note: note)
                someChordList.append(someChord)
            }
            print("someChordList-->\(someChordList)")
            chordDics[chordTitles[i]] = someChordList
        }
    }
    
    
    
    
    /** 读取plist中的数据 **/
//    func documentDirectory()->URL{
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return path[0]
//    }
//    
//    func dataFilePath() -> URL {
//        return documentDirectory().appendingPathComponent("UkuleleChordList.plist")
//    }
//    
//    func readDataFromList(){
//        
//    }
//    
//    
//    func saveChords(){
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWith: data)
////        archiver.encode(chords, forKey: "UkuleleChords")
//        archiver.finishEncoding()
//        print(documentDirectory())
//        print(dataFilePath())
//        data.write(to: dataFilePath(), atomically: true)
//    }



    
}

