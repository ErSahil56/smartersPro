//
//  DashboardViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 08/08/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var movieListTableView: UITableView!
    var header = ["Recent Added","Latest Series","Action Series","SuperNatural Series"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        // Do any additional setup after loading the view.
    }

    func setUpTable(){
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        movieListTableView.register(UINib(nibName: "MovieItemHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieItemHeaderTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell")as! MovieListTableViewCell
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "MovieItemHeaderTableViewCell") as! MovieItemHeaderTableViewCell
        headerCell.headerTitle.text = header[section]
            headerView.addSubview(headerCell)
        
            return headerView
        }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 17.0)
            header.textLabel!.textColor = UIColor.darkGray
            header.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
//    MovieItemHeaderTableViewCell
    
    

    
    
}
