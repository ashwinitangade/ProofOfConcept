//
//  CountryListViewModel.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 02/11/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import Foundation

class CountryListViewModel: NSObject{
    
    @objc dynamic var countryListViewModels :[CountryHeritage] = [CountryHeritage]()
    var title: String = ""
    private var webservice :APIRequest
    private var token :NSKeyValueObservation?
    var bindToSourceViewModels :(() -> ()) = {  }
    
    init(webservice :APIRequest,completion: @escaping CountryHeritageCompletionHandler) {
        
        self.webservice = webservice
        super.init()
        
        token = self.observe(\.countryListViewModels) { _,_ in
            self.bindToSourceViewModels()
        }
        // call getData
        populateData(completion: completion)
    }
    
    func invalidateObservers() {
        self.token?.invalidate()
    }
    
    func populateData(completion: @escaping CountryHeritageCompletionHandler)
    {
        self.webservice.getData { (country, error) in
            if error != nil{
                completion(nil,error)
            }
            if let countryData = country{
                self.countryListViewModels = countryData.rows
                self.title = countryData.title ?? ""
                completion(countryData,nil)
            }
        }
    }
}
class ContryHeritageViewModel : NSObject {
    
    var title: String?
    var desc: String?
    var imageHref: String?
    
    init(title :String, description: String,imageURL: String) {
        self.title = title
        self.desc = description
        self.imageHref = imageURL
    }
    
    init(source :CountryHeritage) {
        
        self.title = source.title
        self.desc = source.desc
        self.imageHref = source.imageHref
    }
}

