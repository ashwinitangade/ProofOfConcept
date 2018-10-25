//
//  ListViewController.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 23/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit
import MBProgressHUD
import Reachability

class ListViewController:UIViewController{
    
    var tableView:UITableView!
    var list: [CountryHeritage] = [CountryHeritage]()
    var apiRequest:APIRequest!
    var refreshControl:UIRefreshControl!
    let network = NetworkReachabilityManager.sharedInstance

    override func viewDidLoad() {
        network.reachability.whenReachable = { reachability in
            self.setUpTableView()
            self.refreshView()
            self.setUpView()
        }
        
    }
    
    //Mark:- setup methods
    func setUpView(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(hexString: "5a98f7")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationAttributes = [.font: UIFont.boldSystemFont(ofSize: CGFloat(Constants.navigationBarFontSize)),NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = navigationAttributes
        self.apiRequest = APIRequest()
        self.apiRequest.delegate = self
        loadData()
    }
    
    func setUpTableView(){
        tableView = UITableView.init(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.view.addSubview(tableView)
        
        // Register table view cells
        tableView.register(CountryHeritageTableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Added Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let tableViewLeadingConstraint = tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let tableViewTrailingConstraint = tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        let tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        self.view.addConstraints([tableViewTopConstraint, tableViewLeadingConstraint,  tableViewTrailingConstraint, tableViewBottomConstraint]);
    }
    
    func refreshView(){
        refreshControl = UIRefreshControl.init()
        refreshControl.tintColor = UIColor.init(hexString: "5a98f7")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action:#selector(loadData), for: .valueChanged)
    }
    
    @objc func loadData(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.apiRequest.getData()
        refreshControl.endRefreshing()
        
    }
}
//Mark:- Tableview delegate methods
extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

//Mark:- Tableview data source methods
extension ListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryHeritageTableViewCell
        cell.setCell(withItem: list[indexPath.row])
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
//Mark:- APIRequestDelagate methods
extension ListViewController:APIRequestDelegate{
    func getCountryData(list: [CountryHeritage],countryTitle:String) {
        self.list = list
        DispatchQueue.main.async {
            self.navigationItem.title = countryTitle
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
