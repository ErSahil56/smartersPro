//
//  WatchTVViewController.swift
//  SmartersPro
//
//  Created by Sahil Garg on 08/09/22.
//

import UIKit

class WatchTVViewController: UIViewController {
    
    @IBOutlet weak var channelCategoryView: UIView!
    @IBOutlet weak var channelButton: UIButton!
    @IBOutlet weak var channelCategoryArrow: UIImageView!
    @IBOutlet weak var selectedChannelLogo: UIImageView!
    @IBOutlet weak var selectedChannelName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var tvScheduleTableView: UITableView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryView: UIView!
    
    var categories = ["Search in categories", "All", "Favourites", "Channel History", "French", "English - USA", "Sports", "World Cricket", "Children", "Spanish"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    override var preferredFocusedView: UIView? {
        if !categoryView.isHidden {
            return categoryTableView
        }
        return channelCategoryView
    }
    
    func setUpTable(){
        
        channelTableView.delegate = self
        channelTableView.dataSource = self
        
        tvScheduleTableView.delegate = self
        tvScheduleTableView.dataSource = self
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        channelTableView.register(UINib(nibName: "channelTableViewCell", bundle: nil), forCellReuseIdentifier: "channelTableViewCell")
        tvScheduleTableView.register(UINib(nibName: "tvScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "tvScheduleTableViewCell")
        categoryTableView.register(UINib(nibName: "categoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryTableViewCell")
        
//        addFocusGuide(from: channelTableView, to: tvScheduleTableView, direction: .right)
//        addFocusGuide(from: tvScheduleTableView, to: channelTableView, direction: .left)
    }
    
    @IBAction func selectCategoryButtonAction(_ sender: UIButton) {
        categoryView.isHidden.toggle()
        if categoryView.isHidden {
            channelTableView.isUserInteractionEnabled = true
        } else {
            channelTableView.isUserInteractionEnabled = false
        }
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
}

//MARK: - UITABLEVIEW METHODS
extension WatchTVViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == channelTableView {
            return 20
        } else if tableView == tvScheduleTableView {
            return 5
        } else {
            return categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == channelTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "channelTableViewCell") as? channelTableViewCell else { return UITableViewCell() }
            cell.indexLabel.text = "\(indexPath.row + 1)"
            return cell
        } else if tableView == tvScheduleTableView  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvScheduleTableViewCell") as? tvScheduleTableViewCell else { return UITableViewCell() }
            if indexPath.row == 0 {
                cell.scheduleLabel.font = THFonts.appRegularFont.withSize(25.0)
            } else {
                cell.scheduleLabel.font = THFonts.appRegularFont.withSize(20.0)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell") as? categoryTableViewCell else { return UITableViewCell() }
            cell.nameLabel.text = categories[indexPath.row]
            cell.searchImageView.isHidden = indexPath.row != 0
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return tableView != tvScheduleTableView
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return tableView != tvScheduleTableView
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if tableView == channelTableView {
            
            if let prevIndexPath = context.previouslyFocusedIndexPath {
                if let prevCell = tableView.cellForRow(at: prevIndexPath) as? channelTableViewCell {
                    prevCell.backgroundColor = UIColor.clear
                    prevCell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }
            
            if let nextIndexPath = context.nextFocusedIndexPath {
                if let nextCell = tableView.cellForRow(at: nextIndexPath) as? channelTableViewCell {
                    nextCell.backgroundColor = THColors.userSelectedColor
                    nextCell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }
            }
        }
        
        if tableView == categoryTableView {
            
            if let prevIndexPath = context.previouslyFocusedIndexPath {
                if let prevCell = tableView.cellForRow(at: prevIndexPath) as? categoryTableViewCell {
                    prevCell.containerView.borderColor = UIColor.clear
                }
            }
            
            if let nextIndexPath = context.nextFocusedIndexPath {
                if let nextCell = tableView.cellForRow(at: nextIndexPath) as? categoryTableViewCell {
                    nextCell.containerView.borderColor = "#9281FF".hexStringToUIColor()
                }
            }
            
        }
        
    }
    
//    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
//
//        if showingFullWidth {
//            return IndexPath(row: selectedIndex, section: 0)
//        }
//        return nil
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryTableView {
            categoryView.isHidden = true
            channelTableView.isUserInteractionEnabled = true
            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
        }
    }
    
}

extension WatchTVViewController {
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            DispatchQueue.main.async {
                self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.015
            }
        }
        
        if context.previouslyFocusedView == channelButton {
            channelCategoryView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            channelCategoryView?.backgroundColor = "#2D315E"
            .hexStringToUIColor()
        }
        
        if context.nextFocusedView == channelButton {
            channelCategoryView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            channelCategoryView?.backgroundColor = THColors.userSelectedColor
        }
        
    }

}
