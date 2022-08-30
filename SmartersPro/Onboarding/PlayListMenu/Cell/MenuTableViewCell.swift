//
//  MenuTableViewCell.swift
//  SmartersPro
//
//  Created by Sahil Garg on 30/08/22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        coordinator.addCoordinatedAnimations ({ [weak self] in
//            if self?.isFocused ?? false {
//                self?.backgroundColor = "#313958".hexStringToUIColor()
//            } else {
//                self?.backgroundColor = .clear
//            }
//        }, completion: nil)
//
//    }
    
}
