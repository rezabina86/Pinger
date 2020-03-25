//
//  PingSummary.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

public struct PingSummary: Equatable {
    var host: IPv4?
    var isReachable: Bool
    
    init(host: String?, isReachable: Bool) {
        self.host = try? IPv4(host ?? "")
        self.isReachable = isReachable
    }
}
