//
//  MovieListCollectionViewCell.swift
//  Smarters Pro
//
//  Created by Keshav on 10/08/22.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var posterImageView: UIImageView!
    static let focusScale: CGFloat = 1.1

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({
                let focusScale = MovieListCollectionViewCell.focusScale
                self.transform = CGAffineTransform(scaleX: focusScale, y: focusScale)
                self.posterImageView.borderColor = THColors.borderThemeColor
            }, completion: nil)
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.transform = .identity
                self.posterImageView.borderColor = .white
            }, completion: nil)
        }
    }
    
}
