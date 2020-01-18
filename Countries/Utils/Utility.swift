//
//  Utility.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation

class Utility {
    
    static func isNetworkReachable() -> Bool {
        do {
            let reachability = try Reachability()
            return reachability.connection != .unavailable
        }
        catch {
            return false
        }
    }
}
