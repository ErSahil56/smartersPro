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


    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

//MARK: - UICOLLECTIONVIEW METHODS
extension ChoosePlaylistViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
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
        cell.personImage.borderWidth = 4
        cell.personImage.borderColor = .clear
        if indexPath.row == 4 {
            cell.personImage.backgroundColor = hexStringToUIColor(hex: "#2D3C68")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionViewCell", for: indexPath) as! PlaylistCollectionViewCell
        cellInddex = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 10) / 4, height: (collectionView.frame.size.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let indexPath = context.previouslyFocusedIndexPath {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionViewCell", for: indexPath) as! PlaylistCollectionViewCell
            cell.personImage.borderWidth = 4
            cell.personImage.borderColor = .clear
        }
        
        if let indexPath = context.nextFocusedIndexPath {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionViewCell", for: indexPath) as! PlaylistCollectionViewCell
            cell.personImage.borderWidth = 4
            cell.personImage.borderColor = UIColor.red
        }
        
    }
    
}
