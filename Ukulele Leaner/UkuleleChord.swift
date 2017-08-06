//
//  UkuleleChord.swift
//  Ukulele Leaner
//
//  Created by HW on 17/2/12.
//  Copyright © 2017年 HW. All rights reserved.
//

import Foundation

class UkuleleChord:NSObject,NSCoding{
    
    var name:String = ""
    var note:String = "note"
    
    init(name:String,note:String) {
        self.name = name
        self.note = note
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    //实现NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(note, forKey: "Note")
    }
}
