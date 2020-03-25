//
//  PingerRange.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-23.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

struct PingerRange {
    
    private let ip: IPv4
    private let size: Int
    private var prevResult: [IPv4]?
    
    init(ip: IPv4, size: Int) {
        self.ip = ip
        self.size = size
    }
    
    public mutating func resetRange() {
        prevResult = nil
    }
    
    public mutating func next() -> [IPv4]? {
        var result: [IPv4] = []
        if let prevResult = prevResult {
            guard prevResult.count == size else { return nil }
            prevResult.forEach { (ip) in
                if let newIP = ip.advanceBy(size) {
                    result.append(newIP)
                }
            }
        } else {
            for i in 1...size {
                result.append(IPv4(ip.ipA, ip.ipB, ip.ipC, UInt8(i)))
            }
        }
        prevResult = result
        return result
    }
    
}
