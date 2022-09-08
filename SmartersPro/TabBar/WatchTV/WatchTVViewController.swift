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
    @IBOutlet weak var selectedChannelLogo: UIImageView!
    @IBOutlet weak var selectedChannelName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var tvScheduleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable(){
        
        channelTableView.delegate = self
        channelTableView.dataSource = self
        
        tvScheduleTableView.delegate = self
        tvScheduleTableView.dataSource = self
        
        channelTableView.register(UINib(nibName: "channelTableViewCell", bundle: nil), forCellReuseIdentifier: "channelTableViewCell")
        tvScheduleTableView.register(UINib(nibName: "tvScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "tvScheduleTableViewCell")
    }
    
}

//MARK: - UITABLEVIEW METHODS
extension WatchTVViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == channelTableView {
            return 20
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == channelTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "channelTableViewCell") as? channelTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvScheduleTableViewCell") as? tvScheduleTableViewCell else { return UITableViewCell() }
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return tableView == channelTableView
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return tableView == channelTableView
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if tableView == channelTableView {
            if let prevIndexPath = context.previouslyFocusedIndexPath {
                let prevCell = tableView.cellForRow(at: prevIndexPath)
                prevCell?.borderColor = UIColor.clear
            }

            if let nextIndexPath = context.nextFocusedIndexPath {
                let nextCell = tableView.cellForRow(at: nextIndexPath)
                nextCell?.borderColor = "#313958".hexStringToUIColor()
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
//        selectedIndex = indexPath.row
    }
    
}

extension WatchTVViewController {
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.2
        }
            
        if context.previouslyFocusedView == channelButton {
            channelCategoryView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            channelCategoryView?.backgroundColor = "#2D315E"
            .hexStringToUIColor()
        }
        
        if context.nextFocusedView == channelButton {
            channelCategoryView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            channelCategoryView?.backgroundColor = "#313958".hexStringToUIColor()
        }
        
    }

}
