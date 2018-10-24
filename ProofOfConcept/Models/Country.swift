//
//  Country.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import Foundation

class Country:NSObject,Codable{
    
    var title:String? = ""
    var rows:[CountryHeritage] = [CountryHeritage]()
    
    private enum CodingKeys: String, CodingKey{
        case title
        case rows
    }
}
