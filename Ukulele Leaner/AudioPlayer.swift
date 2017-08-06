//
//  audioPlayer.swift
//  Ukulele Leaner
//
//  Created by HW on 17/2/14.
//  Copyright © 2017年 HW. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer{
    
    
    var player:AVAudioPlayer?
    var isPlaying:Bool = false
//    var url:URL?
    
    
    
    func play(fileName:String,suffix:String) {
        
        
        do {
            let url = Bundle.main.url(forResource: fileName, withExtension: suffix)
            print("url:\(url)")
            try
                self.player = AVAudioPlayer(contentsOf: url!)
            self.player?.prepareToPlay()
            self.player?.numberOfLoops = 0
            self.player?.volume = 1
            self.player?.prepareToPlay()
            self.player!.play()
        } catch {
            print("error!")
        }
    }
}
