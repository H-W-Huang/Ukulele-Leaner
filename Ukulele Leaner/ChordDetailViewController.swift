//
//  ChordDetailViewController.swift
//  Ukulele Leaner
//
//  Created by HW on 17/2/11.
//  Copyright © 2017年 HW. All rights reserved.
//

import UIKit
import AVFoundation
//
//protocol ChordDetailViewControllerDelegate:class {
//    func chordDetailViewController(_ controller: ChordDetailViewController, didFinishPressing item: UkuleleChord)
//}

class ChordDetailViewController:UIViewController{
    
//    weak var delegate:ChordDetailViewControllerDelegate?
    
    
    var chord:UkuleleChord?
    var player:AudioPlayer?
    @IBOutlet weak var chordImage: UIImageView!
    
    @IBOutlet weak var chordName: UILabel!
    
    override func viewDidLoad() {
        if(chord != nil){
        let imageName:String = chord!.name+".png"
//        print("imageName:"+imageName)
        chordImage.image = UIImage(named:imageName)
        chordName.text = chord?.name
        }
    }
    
    
    @IBAction func playChord(_ sender: Any) {
        print("playing chord!")
//        player = AudioPlayer()
//        player!.play(fileName: "demo",suffix: ".mp3")
    }
    override func didReceiveMemoryWarning() {
        
    }
    
}
