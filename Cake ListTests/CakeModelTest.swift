//
//  CakeModelTest.swift
//  Cake ListTests
//
//  Created by Suman Chatterjee on 07/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import XCTest
//import Foundation
@testable import Cake_List

class CakeModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testParsingCake() {
        
        let bundle = Bundle(for:type(of: self))
        guard let path = bundle.path(forResource: "TestCake", ofType: "json") else { return }
        let data = NSData(contentsOfFile: path)
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode([Cake].self, from:data! as Data)
                XCTAssertEqual(results.count, 2)

                } catch {
                print("JSON Error: \(error)")
            }
            
        }
}
