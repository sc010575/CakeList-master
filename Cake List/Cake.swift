//
//  Cake.swift
//  Cake List
//
//  Created by Suman Chatterjee on 06/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation

 public class Cake: NSObject, Codable {
    
    @objc var title:String?
    @objc var desc:String?
    @objc var image:String?
}

func < (lhs: Cake, rhs: Cake) -> Bool {
    
    guard  let title = lhs.title , let nextTitle = rhs.title  else {
        return false
    }
    return title.localizedStandardCompare(nextTitle) == .orderedAscending
}
