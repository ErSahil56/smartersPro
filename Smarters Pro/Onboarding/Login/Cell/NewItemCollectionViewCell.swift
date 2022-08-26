//
//  NewItemCollectionViewCell.swift
//  Smarters Pro
//
//  Created by Keshav on 06/08/22.
//

import UIKit

class NewItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var newItemsImageView: UIImageView!
    var currentPage = 0
    
    func updatePageControl(){
        pageControl.currentPage = currentPage
    }
    
}
