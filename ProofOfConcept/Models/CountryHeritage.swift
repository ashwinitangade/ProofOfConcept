//
//  CountryHeritage.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import Foundation

class CountryHeritage: NSObject, Codable {
    var title: String? = ""
    var desc: String? = ""
    var imageHref: String = "noImage"
    
    private enum CodingKeys: String, CodingKey {
        case title
        case desc = "description"
        case imageHref
    }
    
}
