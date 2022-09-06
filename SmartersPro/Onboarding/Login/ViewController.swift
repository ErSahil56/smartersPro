//
//  ViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 04/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var anyNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newItemScrollCollectionView: UICollectionView!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var addPlaylistButton: UIButton!
    @IBOutlet weak var connectVPNButton: UIButton!
    @IBOutlet weak var playlistButton: UIButton!
//    @IBOutlet weak var passwordButton: UIButton!
    
    var index = 0
    var inForwardDirection = true
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        newItemScrollCollectionView.delegate = self
        newItemScrollCollectionView.dataSource = self
        newItemScrollCollectionView.register(UINib(nibName: "NewItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewItemCollectionViewCell")
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "By using this application, you agree to the "))
        attributedString.append("Terms of Services".addUnderLine(fontAttribute: THFonts.appRegularFont.withSize(18.0)))
        termsButton.setAttributedTitle(attributedString, for: .normal)
        
        addFocusGuide(from: stackView, to: connectVPNButton, direction: .right)
        addFocusGuide(from: connectVPNButton, to: stackView, direction: .left)
        
    }
    
    func updateUI() {
        
        self.anyNameTextField.setLeftPaddingPoints(60)
        self.userNameTextField.setLeftPaddingPoints(60)
        self.urlTextField.setLeftPaddingPoints(60)
        self.passwordTextField.setLeftPaddingPoints(60)
        
        anyNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Playlist Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        urlTextField.attributedPlaceholder = NSAttributedString(
            string: "Server Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        startTimer()
    }

    @IBAction func addUserAction(_ sender: UIButton) {
        guard let objDashboardView = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController() else { return }
        self.navigationController?.pushViewController(objDashboardView, animated: true)
    }
    
//    @IBAction func passwordSecureAction(_ sender: UIButton) {
//        passwordTextField.isSecureTextEntry.toggle()
//    }
    
    @objc func scrollToNextCell() {
        index += 1
        if index == 3 {
            index = 0
            newItemScrollCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
        } else {
            newItemScrollCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
        }
        
    }

    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
        }
    }
    
}

//MARK: - COLLECTIONVIEW METHODS
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewItemCollectionViewCell", for: indexPath) as! NewItemCollectionViewCell
        cell.updatePageContol()
        cell.pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
        cell.pageControl.currentPage = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width), height: (collectionView.frame.size.height))
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        
        if context.previouslyFocusedView == addPlaylistButton {
            addPlaylistButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        if context.nextFocusedView == addPlaylistButton {
            addPlaylistButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }
        
        if context.previouslyFocusedView == connectVPNButton {
            connectVPNButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        if context.nextFocusedView == connectVPNButton {
            connectVPNButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }
        
        if context.previouslyFocusedView == playlistButton {
            playlistButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        if context.nextFocusedView == playlistButton {
            playlistButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }
        
        if context.previouslyFocusedView == termsButton {
            termsButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        if context.nextFocusedView == termsButton {
            termsButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }
        
        DispatchQueue.main.async {
            
            if context.previouslyFocusedView == self.anyNameTextField {
                self.anyNameTextField.attributedPlaceholder = NSAttributedString(
                    string: "Playlist Name",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
                )
            }
            
            if context.nextFocusedView == self.anyNameTextField {
                self.anyNameTextField.attributedPlaceholder = NSAttributedString(
                    string: "Playlist Name",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
            }
            
            if context.previouslyFocusedView == self.userNameTextField {
                self.userNameTextField.attributedPlaceholder = NSAttributedString(
                    string: "Username",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
                )
            }
            
            if context.nextFocusedView == self.userNameTextField {
                self.userNameTextField.attributedPlaceholder = NSAttributedString(
                    string: "Username",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
            }
            
            if context.previouslyFocusedView == self.passwordTextField {
                self.passwordTextField.attributedPlaceholder = NSAttributedString(
                    string: "Password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
                )
            }
            
            if context.nextFocusedView == self.passwordTextField {
                self.passwordTextField.attributedPlaceholder = NSAttributedString(
                    string: "Password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
            }
            
            if context.previouslyFocusedView == self.urlTextField {
                self.urlTextField.attributedPlaceholder = NSAttributedString(
                    string: "Server Address",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
                )
            }
            
            if context.nextFocusedView == self.urlTextField {
                self.urlTextField.attributedPlaceholder = NSAttributedString(
                    string: "Server Address",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
            }
            
        }

    }
    
}
