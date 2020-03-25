//
//  NetworkScannerResult.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-24.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

class NetworkScannerResult: NSObject {
    
    public var summaries: [PingSummary]
    
    override init() {
        self.summaries = []
    }
    
    public func sort(by option: SortOption) {
        switch option {
        case .ip:
            sortResultsByIP()
        case .reachability:
            sortResultsByReachability()
        }
    }
    
    private func sortResultsByIP() {
        summaries.sort { (s1, s2) -> Bool in
            return s1.host! < s2.host!
        }
    }
    
    private func sortResultsByReachability() {
        sortResultsByIP()
        summaries.sort { (s1, s2) -> Bool in
            return (s1.isReachable && !s2.isReachable)
        }
    }
    
    enum SortOption {
        case ip
        case reachability
    }
    
}
