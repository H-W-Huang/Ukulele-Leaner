//
//  SettingNavigationViewController.swift
//  Ukulele Leaner
//
//  Created by HW on 17/2/14.
//  Copyright © 2017年 HW. All rights reserved.
//


import UIKit

class SettingNavigationViewController:UINavigationController{
    
    override func viewDidLoad() {
        
        print("ChordNavigationViewController initializing")
        //将标题颜色设置为白色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationBar.tintColor = UIColor.white
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


