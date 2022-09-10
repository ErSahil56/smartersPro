//
//  SettingsViewController.swift
//  SmartersPro
//
//  Created by Sahil Garg on 10/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsListCollectionView: UICollectionView!
    
    var settingOptionsName = ["General Settings", "EPG Time Shift","Stream Format","Automation","Time Format","Parental  Control","EPG Timeline","Player selection", "External Player","Multiscreen","Speed test"]

    var settingOptionsImages = ["generalsettings", "clocksettings","streamFormatsettings","automationsettings","timeformatsetttings","parentalsettings","timelinesettings","playerselsettings", "externalsettings","multiscreensettings","speedtestsettings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsListCollectionView.register(UINib(nibName: "settingsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "settingsCollectionViewCell")
    }

}

//MARK: - UICOLLECTIONVIEW METHODS
extension SettingsViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingOptionsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsCollectionViewCell", for: indexPath) as! settingsCollectionViewCell
        cell.personImage.image = UIImage(named: settingOptionsImages[indexPath.row])
        cell.nameLabel.text = settingOptionsName[indexPath.row]
        cell.containerView.borderWidth = 2
        cell.containerView.cornerRadius = 10
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-60)/4, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let indexPath = context.previouslyFocusedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! settingsCollectionViewCell
            cell.containerView.borderColor = .clear
            cell.containerView.backgroundColor = "#28314D".hexStringToUIColor()
            cell.personImage.tintColor = "#9281FF".hexStringToUIColor()
        }

        if let indexPath = context.nextFocusedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! settingsCollectionViewCell
            cell.containerView.borderColor = .white
            cell.containerView.backgroundColor = "#9281FF".hexStringToUIColor()
            cell.personImage.tintColor = .white
        }
        
    }
    
}
