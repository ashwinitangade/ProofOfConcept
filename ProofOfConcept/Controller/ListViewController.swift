//
//  ListViewController.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 23/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit

class ListViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var tableView:UITableView!
    var list: [CountryHeritage] = [CountryHeritage]()
    
    override func viewDidLoad() {
        let item1 = CountryHeritage()
        item1.title = "One"
        item1.desc = "desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one desc one "
        item1.imageHref = "noImage"
        list.append(item1)
        
        let item2 = CountryHeritage()
        item2.title = "Two"
        item2.desc = "desc two"
        item2.imageHref = "noImage"
        list.append(item2)
        
        let item3 = CountryHeritage()
        item3.title = "Three"
        item3.desc = "desc three"
        item3.imageHref = "noImage"
        list.append(item3)
        
        setUpTableView()
        setUpView()
    }
    
    //Mark:- setup methods
    func setUpView(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 1, green: 129, blue: 189, alpha: 0.5)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationAttributes = [.font: UIFont.boldSystemFont(ofSize: CGFloat(Constants.navigationBarFontSize)),NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = navigationAttributes
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

    
    //Mark:- Tableview data source methods
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heritage = self.list[indexPath.row]
        
        var height = 80.0
        if let cell = tableView.cellForRow(at: indexPath) as? CountryHeritageTableViewCell{
            let titleHeight = Double(cell.heightForView(text: heritage.desc!, font: cell.descriptionLabel.font, width: 100))
            let descHeight = Double(cell.heightForView(text: heritage.title!, font: cell.descriptionLabel.font, width: 100))
            height = Double(titleHeight + descHeight)
        }
        
        return CGFloat(height)
    }
    
}
