//
//  PlaylistTypeViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 15/08/22.
//

import UIKit

class PlaylistTypeViewController: UIViewController {
    
    @IBOutlet weak var playlistTypeCollectionView: UICollectionView!
    @IBOutlet weak var showMoreButton: UIButton!
    
    var imageArray = ["mp3", "xtream", "stalker", "playlist", "singleplaylist"]
    var userArray = ["M3U URL/FILE", "XTREAM CODES", "STALKER PORTAL", "LOCAL PLAYLIST", "SINGLE STREAM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTypeCollectionView.register(UINib(nibName: "PlaylistTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaylistTypeCollectionViewCell")
    }
    
    @IBAction func buttonShowMoreAction(_ sender: UIButton) {
        showMoreButton.isSelected.toggle()
        if showMoreButton.isSelected {
            showMoreButton.setTitle("Show Less", for: .normal)
        } else {
            showMoreButton.setTitle("Show More", for: .normal)
        }
        playlistTypeCollectionView.reloadData()
    }
    
}

//MARK: - UICOLLECTIONVIEW METHODS
extension PlaylistTypeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showMoreButton.isSelected {
            return userArray.count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistTypeCollectionViewCell", for: indexPath) as! PlaylistTypeCollectionViewCell
        cell.personImage.image = UIImage(named: imageArray[indexPath.row])
        cell.nameLabel.text = userArray[indexPath.row]
        cell.containerView.borderWidth = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(objViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-160)/3, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let indexPath = context.previouslyFocusedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! PlaylistTypeCollectionViewCell
            cell.containerView.borderWidth = 8
            cell.containerView.borderColor = .clear
        }
        
        if let indexPath = context.nextFocusedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! PlaylistTypeCollectionViewCell
            cell.containerView.borderWidth = 8
            cell.containerView.borderColor = THColors.borderThemeColor
        }
        
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if context.previouslyFocusedView == showMoreButton {
            showMoreButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        if context.nextFocusedView == showMoreButton {
            showMoreButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }
        
    }
    
}
