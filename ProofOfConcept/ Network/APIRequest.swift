//
//  APIRequest.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import Foundation
import UIKit

enum POCError: Error {
    case invalidUrl
    case noResultsFound
}
typealias  CountryHeritageCompletionHandler = (Country?, Error?) -> Void

class APIRequest: NSObject{
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    convenience override init () {
        self.init(session: URLSession(configuration: .default))
    }
    
    func getData(completion: @escaping CountryHeritageCompletionHandler) {
        guard let popularNYNewsurl = URL(string: Constants.baseURL) else {
            completion(nil, POCError.invalidUrl)
            return
        }
        let task =  session.dataTask(with: popularNYNewsurl) { (data, _, error) in
            guard let responseData = data, error == nil else {
                completion(nil, error)
                return
            }
            let stringValue = String(data: responseData, encoding: .ascii)
            guard let errorFreeData = stringValue?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                let decoder = JSONDecoder()
                let country = try decoder.decode(Country.self, from:
                    errorFreeData) //Decode JSON Response Data
                completion(country, nil)
            } catch let error {
                print("json error: \(error)")
                completion(nil,error)
            }
        }
        task.resume()
    }
}
