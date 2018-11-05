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

    //Mark: - View loading tests
    func testThatViewLoads()
    {
        XCTAssertNotNil(listViewController.view, "View not initiated properly");
    }
    
    func testParentViewHasTableViewSubview()
    {
        let subviews = listViewController.view.subviews;
        XCTAssertTrue(subviews.contains(listViewController.tableView), "View does not have a table subview");
    }
    
    func testThatTableViewLoads()
    {
        XCTAssertNotNil(listViewController.tableView, "TableView not initiated");
    }
    
    func testToConformUITableViewDataSource(){
        XCTAssertTrue(CountryListViewController.conforms(to: UITableViewDataSource.self), "View does not confirm to UITableViewDataSource")
    }
   
    func testNavigationTitle(){
        XCTAssertTrue(listViewController.countryListViewModel.title ==  "", "Navigation bar does not have a title")
    }
    
    func testToCheckIfTableViewCellisRegistered(){
        listViewController.tableView.register(CountryHeritageTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        let cell = listViewController.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        XCTAssertNotNil(cell, "Cell must be an instance of CountryHeritageTableViewCell")
    }
    
    func testTableViewCellData()
    {
        let tableView = listViewController.tableView!
        for (index,_) in listViewController.countryListViewModel.countryListViewModels.enumerated(){
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? CountryHeritageTableViewCell
            {
                let rowtitle = cell.titleLabel.text
                XCTAssertTrue(rowtitle != nil, "Title is not nil")
                let rowDesc = cell.descriptionLabel.text
                XCTAssertTrue(rowDesc != nil, "description is not nil")

            }

        }
        
        
    }

}
