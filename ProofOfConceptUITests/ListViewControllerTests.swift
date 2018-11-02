//
//  ListViewControllerTests.swift
//  ProofOfConceptUITests
//
//  Created by AshwiniT on 26/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import XCTest
@testable import ProofOfConcept

class ListViewControllerTests: XCTestCase {

    var listViewController = CountryListViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        listViewController.setUpTableView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Mark: UITableview tests
    func testIfTableViewISNotNil(){
        XCTAssertNotNil(listViewController.tableView, "Table view is not initialised")
    }
    
    func testToConformUITableViewDataSource(){
        XCTAssertTrue(CountryListViewController.conforms(to: UITableViewDataSource.self), "View does not confirm to UITableViewDataSource")
    }
   
    func testNavigationTitle(){
        XCTAssertTrue(listViewController.countryListViewModel.title !=  "", "Navigation bar does not have a title")
    }
    
    func testToCheckIfTableViewCellisRegistered(){
        listViewController.tableView.register(CountryHeritageTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        let cell = listViewController.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        XCTAssertNotNil(cell, "Cell must be an instance of CountryHeritageTableViewCell")
    }

}
