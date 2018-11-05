//
//  CountryListVCExtension+TableViewDataSource.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 29/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit

//Mark:- Tableview data source methods
extension CountryListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countryListViewModel != nil{
                return self.countryListViewModel.countryListViewModels.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CountryHeritageTableViewCell
        cell.setCell(withItem: self.countryListViewModel.countryListViewModels[indexPath.row])
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
