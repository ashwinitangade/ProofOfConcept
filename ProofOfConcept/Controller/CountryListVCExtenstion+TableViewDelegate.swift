//
//  CountryListVCExtenstion+TableViewDelegate.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 29/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit

//Mark:- Tableview delegate methods
extension CountryListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
