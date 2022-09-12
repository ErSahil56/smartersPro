//
//  PlaylistMenuViewController.swift
//  SmartersPro
//
//  Created by Sahil Garg on 30/08/22.
//

import UIKit

enum PopUPViewType {
    case playlistMenuOptions
    case sidebarSettings
}

class PopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var popViewType: PopUPViewType = .playlistMenuOptions
    
    var cellIndexClicked: ((Int)->())?
    
    var arrayMenu = ["Edit", "Delete"]
    var arrayImages = ["editMenu", "deleteMenu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if popViewType == .sidebarSettings {
            arrayMenu = ["My Account","Switch User","Add User","Exit"]
            arrayImages = ["accountSideMenu","swapSideMenu","addUserSideMenu","exitSideMenu"]
        }
        self.tableViewHeight.constant = CGFloat(arrayMenu.count * 55 + 20)
        self.tableView.reloadData()
    }
}

//MARK: - UITABLEVIEW METHODS
extension PopUpViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuLabel.text = arrayMenu[indexPath.row]
        cell.menuImage.image = UIImage(named: arrayImages[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if let prevIndexPath = context.previouslyFocusedIndexPath {
            let prevCell = tableView.cellForRow(at: prevIndexPath)
            prevCell?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            prevCell?.backgroundColor = UIColor.clear
            prevCell?.cornerRadius = 0.0
        }

        if let nextIndexPath = context.nextFocusedIndexPath {
            let nextCell = tableView.cellForRow(at: nextIndexPath)
            nextCell?.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            nextCell?.backgroundColor = THColors.userSelectedColor
            nextCell?.cornerRadius = 20.0
        }

    }
    
}
