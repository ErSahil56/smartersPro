//
//  SideMenuViewController.swift
//  SmartersPro
//
//  Created by Sahil Garg on 31/08/22.
//

import UIKit

class SideMenuViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var sideTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    static var initialPhase = true
    
    var showDetailController = true
    var selectedIndex = 1
    
    var arrayMenu = ["Watch tv", "Movies", "Series", "Live With EPG", "Catach Up", "My Recordings", "Radio", "Notification", "Settings"]
    var arrayImages = ["tvmenu", "moviemenu", "seriesmenu", "epgmenu", "catchmenu", "voicemenu", "radiomenu", "notificationmenu", "settingsmenu"]
     
    override var preferredFocusedView: UIView? {
        if showDetailController {
            return self.splitViewController?.viewControllers[1].view
        } else {
            return self.sideTableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.maximumPrimaryColumnWidth = CGFloat(MAXFLOAT)
        splitViewController?.preferredPrimaryColumnWidthFraction = 0.2
        sideTableView.allowsSelection = true
        sideTableView.register(UINib(nibName: "SideTableViewCell", bundle: nil), forCellReuseIdentifier: "SideTableViewCell")
        sideTableView.contentInsetAdjustmentBehavior = .never
        sideTableView.insetsContentViewsToSafeArea = false
        sideTableView.insetsLayoutMarginsFromSafeArea = false
        sideTableView.preservesSuperviewLayoutMargins = false
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUIOnSidebar(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        sideTableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.none)
        self.updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !SideMenuViewController.initialPhase {
            if self.splitViewController?.preferredPrimaryColumnWidthFraction == 0.2 {
                showDetailController = false
            } else {
                showDetailController = true
            }
            self.updateUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
    func updateUI() {
        if !showDetailController {
            searchButton.setTitle("Master Search", for: .normal)
        } else {
            searchButton.setTitle("", for: .normal)
        }
        sideTableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.top)
        sideTableView.reloadData()
    }
    
//    @objc func updateUIOnSidebar(notification: Notification) {
//        self.updateUI()
//    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        let searchController = UISearchController(searchResultsController: UIViewController())
        searchController.searchBar.placeholder = NSLocalizedString("Enter keyword", comment: "")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        let searchNavigationController = UINavigationController(rootViewController: searchContainer)
        present(searchNavigationController, animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text as Any)
    }
    
    @IBAction func accountButtonPressed(_ sender: UIButton) {
        let menuController = PopUpViewController()
        menuController.popViewType = .sidebarSettings
        menuController.cellIndexClicked = { index in
            print(index)
        }
        self.present(menuController, animated: true, completion: nil)
    }
    
    
}

//MARK: - UITABLEVIEW METHODS
extension SideMenuViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideTableViewCell") as! SideTableViewCell
        cell.selectedView.isHidden = true
        if !showDetailController {
            cell.menuLabel.text = arrayMenu[indexPath.row]
            cell.selectedView.isHidden = true
            cell.menuImage.image = UIImage(named: arrayImages[indexPath.row])
        } else {
            cell.menuLabel.text = ""
            cell.menuImage.image = UIImage(named: arrayImages[indexPath.row])
            if selectedIndex == indexPath.row {
                cell.selectedView.isHidden = false
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if let prevIndexPath = context.previouslyFocusedIndexPath {
            let prevCell = tableView.cellForRow(at: prevIndexPath)
            prevCell?.backgroundColor = UIColor.clear
        }

        if let nextIndexPath = context.nextFocusedIndexPath {
            let nextCell = tableView.cellForRow(at: nextIndexPath)
            nextCell?.backgroundColor = THColors.userSelectedColor
        }

    }
    
    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        
        if showDetailController {
            return IndexPath(row: selectedIndex, section: 0)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if selectedIndex == 0 {
            showDetailController = true
            let watchTv = WatchTVViewController()
            self.splitViewController?.showDetailViewController(watchTv, sender: self)
        }
        if selectedIndex == 1 {
            if let dashboard = UIStoryboard.init(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
                showDetailController = true
                dashboard.dashType = .movies
                self.splitViewController?.showDetailViewController(dashboard, sender: self)
                
            }
        }
        if selectedIndex == 2 {
            if let dashboard = UIStoryboard.init(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
                showDetailController = true
                dashboard.dashType = .series
                self.splitViewController?.showDetailViewController(dashboard, sender: self)
            }
        }
        if selectedIndex == 8 {
            let settingsvc = SettingsViewController()
//            self.navigationController?.pushViewController(settingsvc, animated: true)
            self.splitViewController?.showDetailViewController(settingsvc, sender: self)
        }
        self.updateUI()
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
}

extension SideMenuViewController {
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            DispatchQueue.main.async {
                self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.2
            }
        }
        
        if context.previouslyFocusedView == searchButton {
            searchButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            searchView?.backgroundColor = "#1E2D53"
            .hexStringToUIColor()
        }
        
        if context.nextFocusedView == searchButton {
            searchButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            searchView?.backgroundColor = THColors.userSelectedColor
        }
        
        if context.previouslyFocusedView == profileButton {
            profileButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            profileButton?.backgroundColor = .clear
        }
        
        if context.nextFocusedView == profileButton {
            profileButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            profileButton?.backgroundColor = THColors.userSelectedColor
        }
        
        if context.previouslyFocusedView == menuButton {
            menuButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            menuButton?.backgroundColor = .clear
        }
        
        if context.nextFocusedView == menuButton {
            menuButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            menuButton?.backgroundColor = THColors.userSelectedColor
        }
        
    }

}

