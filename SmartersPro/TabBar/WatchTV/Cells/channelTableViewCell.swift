//
//  channelTableViewCell.swift
//  SmartersPro
//
//  Created by Sahil Garg on 08/09/22.
//

import UIKit

class channelTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var channelLogoImageView: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelInfoLabel: UILabel!
    @IBOutlet weak var channelTimeLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var unprogressView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
