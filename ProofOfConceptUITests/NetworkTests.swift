//
//  NetworkTests.swift
//  ProofOfConceptUITests
//
//  Created by AshwiniT on 26/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import XCTest
@testable import ProofOfConcept

class NetworkTests: XCTestCase {

    let networkRequest = APIRequest()
    let listviewController = CountryListViewController()
    let networkReachabilty = NetworkReachabilityManager.sharedInstance
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        listviewController.loadData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Mark:- reachability
    func testIfNetworkisReachable(){
        NetworkReachabilityManager.isUnreachable { reachable in
            if (reachable.reachability.connection == .none){
                XCTAssert((reachable.reachability.connection == .none), "Not connected to Internet")
            }
        }
       
    }
    
    //Mark:- test service request
    func testServiceCallSuccess() {
        listviewController.apiRequest = APIRequest()
        listviewController.countryListViewModel = CountryListViewModel(webservice: listviewController.apiRequest, completion: { (country, error) in
            XCTAssertTrue(error != nil, "service request call is success without any errors")
        })
    }
    
    func testDataReceivedCountIsGreaterThanZero() {
        listviewController.apiRequest = APIRequest()
        listviewController.countryListViewModel = CountryListViewModel(webservice: listviewController.apiRequest, completion: { (country, error) in
            if let rows = country?.rows.count{
                XCTAssertTrue(rows > 0, "service response data has more data")
            }
        })
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
