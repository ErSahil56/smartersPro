//
//  DashboardViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 08/08/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var sortButton: UIButton!
    
    private var storedOffsets = [Int: CGFloat]()
    
    var header = ["Similar Category","Latest Movies","Action Movies","SuperNatural Movies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.layoutGradient()
    }
    
    func setUpTable(){
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        
        movieListTableView.allowsSelection = false
        
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        movieListTableView.register(UINib(nibName: "MovieItemHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieItemHeaderTableViewCell")
        
        addFocusGuide(from: movieListTableView, to: sortButton, direction: .top)
        addFocusGuide(from: sortButton, to: movieListTableView, direction: .bottom)
        
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sort", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "By Rating", style: .default , handler:{ (UIAlertAction)in
            print("User click Rating button")
        }))
        
        alert.addAction(UIAlertAction(title: "By Popularity", style: .default , handler:{ (UIAlertAction)in
            print("User click Popularity button")
        }))
        
        alert.addAction(UIAlertAction(title: "By Genre", style: .default , handler:{ (UIAlertAction)in
            print("User click Genre button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
}

//MARK: - UITABLEVIEW METHODS

extension DashboardViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieListTableViewCell else { return }
        cell.setCollectionViewDataSourceDelegate(forRow: indexPath.row)
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "MovieItemHeaderTableViewCell") as! MovieItemHeaderTableViewCell
        headerCell.headerTitle.text = header[section]
        headerView.addSubview(headerCell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380 * MovieListCollectionViewCell.focusScale
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieListTableViewCell else { return }
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
}

extension DashboardViewController {
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.015
        }
        
        if context.previouslyFocusedView == sortButton {
            sortButton.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
        
        if context.nextFocusedView == sortButton {
            sortButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }
        
    }

}
