//
//  ChoosePlaylistViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 18/08/22.
//

import UIKit

class ChoosePlaylistViewController: UIViewController {
    
    @IBOutlet weak var choosePlaylistCollectionView: UICollectionView!
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    
    var imageArray = [UIImage(named: "person")!, UIImage(named: "person1")!,UIImage(named: "person2")!,UIImage(named: "person3")! ,UIImage(named: "plus")!]
    var userArray = ["John", "Alex", "James", "Steven", "Add Playlist"]
    var cellInddex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePlaylistCollectionView.register(UINib(nibName: "PlaylistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaylistCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - UICOLLECTIONVIEW METHODS
extension ChoosePlaylistViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionViewCell", for: indexPath) as! PlaylistCollectionViewCell
        cell.personImage.image = imageArray[indexPath.row]
        cell.nameLabel.text = userArray[indexPath.row]
        cell.containerView.borderWidth = 8
        if indexPath.row == 4 {
            cell.personImage.backgroundColor = "#2D3C68".hexStringToUIColor()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            let objPlaylistType = self.storyboard?.instantiateViewController(withIdentifier: "PlaylistTypeViewController") as! PlaylistTypeViewController
            self.navigationController?.pushViewController(objPlaylistType, animated: true)
        } else {
            let objViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(objViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let indexPath = context.previouslyFocusedIndexPath {
            let cell = collectionView.cellForItem(at:   indexPath) as! PlaylistCollectionViewCell
            cell.containerView.borderWidth = 8
            cell.containerView.borderColor = .clear
        }
        
        if let indexPath = context.nextFocusedIndexPath {
            let cell = collectionView.cellForItem(at:   indexPath) as! PlaylistCollectionViewCell
            cell.containerView.borderWidth = 8
            cell.containerView.borderColor = THColors.borderThemeColor
        }
        
    }
    
}
