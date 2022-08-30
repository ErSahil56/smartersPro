//
//  PlaylistCollectionViewCell.swift
//  Smarters Pro
//
//  Created by Keshav on 18/08/22.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var personContainerView: UIView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var buttonClicked: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        longGesture.minimumPressDuration = 2.0
        self.addGestureRecognizer(longGesture)
    }
    
    @objc func longPress(longPressGestureRecognizer : UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == .began {
            self.buttonClicked?()
        }
        
    }
    
}
