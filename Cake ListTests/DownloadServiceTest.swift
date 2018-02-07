//
//  DownloadServiceTest.swift
//  Cake ListTests
//
//  Created by Suman Chatterjee on 07/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import XCTest
import Foundation
@testable import Cake_List

class DownloadServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDownloadService() {
        
        let downloadExpectiation = expectation(description: "Download Cake.JSON")
        let downloadService:DownloadService = DownloadService()

        downloadService.performLoadJSON(with: CakeJSONUrl ,completion: { success in
            
            if downloadService.cakeLists.isEmpty {
                
                XCTAssertNotNil(downloadService.cakeLists.isEmpty, "cake lists have no data")

            }
            downloadExpectiation.fulfill()
        })
         waitForExpectations(timeout: 10) { (error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }

    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            self.testDownloadService()
        }
    }
    
}
