//
//  CountryListViewController.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 23/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit
import MBProgressHUD
import Reachability

class CountryListViewController:UIViewController{
    
    var tableView:UITableView!
    var countryListViewModel:CountryListViewModel!
    var apiRequest:APIRequest!
    var refreshControl:UIRefreshControl!
    let network = NetworkReachabilityManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.setUpView()
        
        NetworkReachabilityManager.isReachable { _ in
            self.refreshView()
        }
        NetworkReachabilityManager.isUnreachable { (_) in
            UIUtilities.alertWith(title: "Error", message: "No Internet Connection", viewCtlr: self)
        }
        self.changeUIAsPerNetworkAvailability()
        
    }
    
    //Mark:- setup methods
    func setUpView(){
        self.view.backgroundColor = UIColor.white
        UIUtilities.navigationBarAppearance()
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
        tableView.register(CountryHeritageTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
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
        refreshControl.tintColor = UIColor.gray
        loadData()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action:#selector(loadData), for: .valueChanged)
    }
    
    @objc func loadData(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.apiRequest = APIRequest()
        self.countryListViewModel = CountryListViewModel(webservice: self.apiRequest, completion: { (country, error) in
            if error != nil{
                UIUtilities.alertWith(title: "Error", message: error.debugDescription, viewCtlr: self)
                self.updateTableView()
                return
            }
            self.updateTableView()
        })
        self.countryListViewModel.bindToSourceViewModels = {
            self.updateTableView()
        }
        refreshControl.endRefreshing()
        
    }
    
    func changeUIAsPerNetworkAvailability(){
        network.reachability.whenUnreachable = { reachability in
            UIUtilities.alertWith(title: "Error", message: "No Internet Connection", viewCtlr: self)
                DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        network.reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateTableView(){
        DispatchQueue.main.async {
            self.navigationItem.title = self.countryListViewModel.title
            self.tableView.reloadData()
            if self.countryListViewModel.countryListViewModels.count <= 0{
                UIUtilities.alertWith(title: "Info", message: "No Data received from Server", viewCtlr: self)
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}
