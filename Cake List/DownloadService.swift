//
//  DownloadService.swift
//  Cake List
//
//  Created by Suman Chatterjee on 06/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation
import UIKit

//@objc public class CakeViewModel: NSObject {
//    
//    var title:String?
//    var desc:String?
//    var image:String?
//    
//    
//}
@objc public class TestCake: NSObject {
    
   @objc var title:String?
    var desc:String?
    var image:String?

}

public typealias SearchComplete = (Bool) -> Void

public class DownloadService:NSObject {

    @objc enum State:Int {
        case notSearchedYet
        case loading
        case noResults
        case results
    }
    private var dataTask: URLSessionDataTask? = nil
    @objc var state: State = .notSearchedYet
    @objc var cakeLists = [Cake]()
    
  @objc public func testFunc() {
        
        print("Hello")
    self.performSearch { success in
        print("Downloaded")
    }
    }
   @objc public func performSearch(with completion: @escaping SearchComplete) {
        dataTask?.cancel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Update state
        var success = false
        state = .loading
        
        let url = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
        
        
        guard let finalUrl = URL(string: url) else {
            return completion(success)
            
        }
        let session = URLSession.shared
        
        
        dataTask = session.dataTask(with: finalUrl, completionHandler: {
            data, response, error in
            var newState = State.notSearchedYet
            // Was the search cancelled?
            if let error = error as NSError?, error.code == -999 {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200, let data = data {
                var searchResults = self.parse(data: data)
                if searchResults.isEmpty {
                    newState = .noResults
                } else {
                    searchResults.sort(by: <)
                    newState = .results
                    self.cakeLists = searchResults
                }
                success = true
            }
            DispatchQueue.main.async {
                self.state = newState
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(success)
            }
        })
        dataTask?.resume()
    }
    
}

// MARK:- Private Methods
private extension DownloadService {
    
    func parse(data: Data) -> [Cake] {
        do {
            let decoder = JSONDecoder()
            let results = try decoder.decode([Cake].self, from:data)
            return results
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
}


