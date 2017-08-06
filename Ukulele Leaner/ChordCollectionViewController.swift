//
//  ChordCollectionViewController.swift
//  Ukulele Leaner
//
//  Created by HW on 17/2/16.
//  Copyright © 2017年 HW. All rights reserved.
//

import UIKit

class ChordCollectionViewController:UICollectionViewController{
    
    
    
    override func viewDidLoad() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChordCollectionCell", for: indexPath)
        return cell
    }
}
