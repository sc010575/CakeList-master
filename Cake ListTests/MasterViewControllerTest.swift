//
//  MasterViewControllerTest.swift
//  Cake ListTests
//
//  Created by Suman Chatterjee on 07/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import Cake_List

class MasterViewControllerTest: XCTestCase {
    
    var systemUnderTest: MasterViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        systemUnderTest = navigationController.topViewController as! MasterViewController
        
        //Load View hierarchy
        _ = systemUnderTest.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(systemUnderTest.tableView)
    }
    
    func test_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
    func test_ShouldSetTableViewDelegate() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
    func testSUT_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
}
