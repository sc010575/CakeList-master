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
    
    var filePath : String? {
        let bundle = Bundle(for:type(of: self))
        guard let path = bundle.path(forResource: "TestCake", ofType: "json") else { return nil}
        return path
    }
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testParsingCakeList() {
        
        guard let path  = filePath else { return }
        let data = NSData(contentsOfFile: path)
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode([Cake].self, from:data! as Data)
                XCTAssertEqual(results.count, 2)

                } catch {
                print("JSON Error: \(error)")
            }
            
        }
    
    func testParsingCakeTitle() {
        guard let path  = filePath else { return }
        let data = NSData(contentsOfFile: path)
        do {
            let decoder = JSONDecoder()
            let results = try decoder.decode([Cake].self, from:data! as Data)
            let cake:Cake = results[0]
            XCTAssertEqual(cake.title,"Lemon cheesecake")
            let cakeTwo:Cake = results[1]
            XCTAssertEqual(cakeTwo.title,"victoria sponge")

        } catch {
            print("JSON Error: \(error)")
        }
    }

        func testParsingCakeDescription() {
            guard let path  = filePath else { return }
            let data = NSData(contentsOfFile: path)
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode([Cake].self, from:data! as Data)
                let cake:Cake = results[0]
                XCTAssertEqual(cake.desc,"A cheesecake made of lemon")
                let cakeTwo:Cake = results[1]
                XCTAssertEqual(cakeTwo.desc,"sponge with jam")
                
            } catch {
                print("JSON Error: \(error)")
            }
    }
}
