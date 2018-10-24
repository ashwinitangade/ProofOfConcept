//
//  APIRequest.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import Foundation
import UIKit

protocol APIRequestDelegate: class {
    func getCountryData(list: [CountryHeritage])
}

class APIRequest: NSObject{
    
    weak var delegate:APIRequestDelegate?
    
    func getData(){
    // Asynchronously API is hit here
        guard let url = URL(string: Constants.baseURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let stringValue = String(data: dataResponse, encoding: .ascii) ?? ""
                let errorFreeData = stringValue.data(using: .utf8)! as Data
                let decoder = JSONDecoder()
                let country = try decoder.decode(Country.self, from:
                    errorFreeData) //Decode JSON Response Data
                self.delegate?.getCountryData(list: country.rows)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
