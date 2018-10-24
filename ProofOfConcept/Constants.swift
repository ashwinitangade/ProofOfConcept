//
//  Constants.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 24/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import UIKit

struct Constants {
    static let baseURL: URL = {
        return URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    }()
    static let leadingConstant = 20
    static let trailingConstant = 20
    static let topAndBottomConstant = 10
    static let imageViewWidthConstant = 100
    static let bottomLineHeightConstant = 1
    static let bottomLineBottomConstant = -1
    static let descriptionLabelFontSize = 14
    static let titleLabelFontSize = 16
    static let navigationBarFontSize = 17
}
