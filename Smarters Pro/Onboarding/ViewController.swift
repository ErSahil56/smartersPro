//
//  ViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 04/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listUserButton: UIButton!
    @IBOutlet weak var ListUserImage: UIImageView!
    @IBOutlet weak var anyNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newItemScrollCollectionView: UICollectionView!
    
    var index = 0
    var inForwardDirection = true
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        newItemScrollCollectionView.delegate = self
        newItemScrollCollectionView.dataSource = self
        newItemScrollCollectionView.register(UINib(nibName: "NewItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewItemCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        self.anyNameTextField.setLeftPaddingPoints(60)
        self.userNameTextField.setLeftPaddingPoints(60)
        self.urlTextField.setLeftPaddingPoints(60)
        self.passwordTextField.setLeftPaddingPoints(60)
        ListUserImage.image = UIImage(named:"PersonList")
        anyNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Anyname",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        urlTextField.attributedPlaceholder = NSAttributedString(
            string: "Url",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        startTimer()
    }


    @IBAction func addUserAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func scrollToNextCell() {

        //scroll to next cell
        let items = newItemScrollCollectionView.numberOfItems(inSection: 0)
        if (items - 1) == index {
            newItemScrollCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        } else if index == 0 {
            newItemScrollCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            newItemScrollCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }

        if inForwardDirection {
            if index == (items - 1) {
                index -= 1
                inForwardDirection = false
            } else {
                index += 1
            }
        } else {
            if index == 0 {
                index += 1
                inForwardDirection = true
            } else {
                index -= 1
            }
        }
        
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
        }
    }
    
}

//MARK: - COLLECTION VIEW NEW ITEM PAGINATION
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewItemCollectionViewCell", for: indexPath) as! NewItemCollectionViewCell
        cell.pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
        cell.pageControl.hidesForSinglePage = true
        cell.updatePageControl()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewItemCollectionViewCell", for: indexPath) as! NewItemCollectionViewCell
        cell.pageControl.currentPage = indexPath.section
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (collectionView.frame.size.width - 10) / 1, height: (collectionView.frame.size.height ))
    }
    
    
}
