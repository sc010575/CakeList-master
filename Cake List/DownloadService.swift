//
//  DownloadService.swift
//  Cake List
//
//  Created by Suman Chatterjee on 06/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation
import UIKit

public typealias LoadingComplete = (Bool) -> Void

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

    @objc public func performLoadJSON(with url:String ,completion: @escaping LoadingComplete) {
        dataTask?.cancel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Update state
        var success = false
        state = .loading
        
        guard let finalUrl = URL(string: url) else {
            return completion(success)
            
        }
        let session = URLSession.shared
        dataTask = session.dataTask(with: finalUrl, completionHandler: {
            data, response, error in
            var newState = State.notSearchedYet
            // Was the download cancelled?
            if let error = error as NSError?, error.code == -999 {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200, let data = data {
                var results = self.parse(data: data)
                if results.isEmpty {
                    newState = .noResults
                } else {
                    results.sort(by: <)
                    newState = .results
                    self.cakeLists = results
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


