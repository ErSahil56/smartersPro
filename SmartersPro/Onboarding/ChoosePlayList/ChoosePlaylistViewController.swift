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
    
    var imageArray = [UIImage(named: "person")!, UIImage(named: "person1")!,UIImage(named: "person2")!,UIImage(named: "person3")!]
    var userArray = ["John", "Alex", "James", "Steven"]
    var cellInddex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePlaylistCollectionView.register(UINib(nibName: "PlaylistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaylistCollectionViewCell")
        choosePlaylistCollectionView.register(UINib(nibName: "AddPlaylistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlaylistCollectionViewCell")
    }
    
}

//MARK: - UICOLLECTIONVIEW METHODS
extension ChoosePlaylistViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return imageArray.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionViewCell", for: indexPath) as! PlaylistCollectionViewCell
            cell.personImage.image = imageArray[indexPath.row]
            cell.nameLabel.text = userArray[indexPath.row]
            cell.containerView.borderWidth = 8
            cell.buttonClicked = {
                let menuController = PopUpViewController()
                menuController.popViewType = .playlistMenuOptions
                menuController.cellIndexClicked = { index in
                    print(index)
                }
                self.present(menuController, animated: true, completion: nil)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlaylistCollectionViewCell", for: indexPath) as! AddPlaylistCollectionViewCell
            cell.containerView.borderWidth = 8
            cell.personContainerView.backgroundColor = THColors.themeBackGroundColor
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let objPlaylistType = self.storyboard?.instantiateViewController(withIdentifier: "PlaylistTypeViewController") as! PlaylistTypeViewController
            self.navigationController?.pushViewController(objPlaylistType, animated: true)
        } else {
            guard let objDashboardView = UIStoryboard(name: "Tabbar", bundle: nil).instantiateInitialViewController() else { return }
            self.navigationController?.pushViewController(objDashboardView, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let indexPath = context.previouslyFocusedIndexPath {
            if indexPath.section == 0 {
                let cell = collectionView.cellForItem(at: indexPath) as! PlaylistCollectionViewCell
                cell.containerView.borderWidth = 8
                cell.containerView.borderColor = .clear
                cell.containerView.backgroundColor = .clear
                cell.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            if indexPath.section == 1 {
                let cell = collectionView.cellForItem(at: indexPath) as! AddPlaylistCollectionViewCell
                cell.containerView.borderWidth = 8
                cell.containerView.borderColor = .clear
                cell.containerView.backgroundColor = .clear
                cell.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
        
        if let indexPath = context.nextFocusedIndexPath {
            if indexPath.section == 0 {
                let cell = collectionView.cellForItem(at: indexPath) as! PlaylistCollectionViewCell
                cell.containerView.borderWidth = 8
                cell.containerView.borderColor = THColors.borderThemeColor
                cell.containerView.backgroundColor = THColors.userSelectedColor
                cell.containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            if indexPath.section == 1 {
                let cell = collectionView.cellForItem(at: indexPath) as! AddPlaylistCollectionViewCell
                cell.containerView.borderWidth = 8
                cell.containerView.borderColor = THColors.borderThemeColor
                cell.containerView.backgroundColor = THColors.userSelectedColor
                cell.containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            
        }
        
    }
    
}
