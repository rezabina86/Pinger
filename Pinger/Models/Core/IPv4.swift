//
//  IPv4.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-22.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

struct IPv4: CustomStringConvertible, Equatable, Hashable, Comparable {
    

    var ipA: UInt8
    var ipB: UInt8
    var ipC: UInt8
    var ipD: UInt8

    init(_ ipA: UInt8, _ ipB: UInt8, _ ipC: UInt8, _ ipD: UInt8) {
        self.ipA = ipA
        self.ipB = ipB
        self.ipC = ipC
        self.ipD = ipD
    }

    private static let parsingRegex = try! NSRegularExpression(pattern: "^([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})$")
    
    init(_ ipString: String) throws {
        guard let match = IPv4.parsingRegex.firstMatch(in: ipString, range: NSRange(0..<ipString.utf16.count)) else { throw Errors.invalidFormat }
        let strA = ipString[Range(match.range(at: 1), in: ipString)!]
        let strB = ipString[Range(match.range(at: 2), in: ipString)!]
        let strC = ipString[Range(match.range(at: 3), in: ipString)!]
        let strD = ipString[Range(match.range(at: 4), in: ipString)!]
        guard let ipA = UInt8(strA), let ipB = UInt8(strB), let ipC = UInt8(strC), let ipD = UInt8(strD) else { throw Errors.octetOutOfRange }
        self.ipA = ipA
        self.ipB = ipB
        self.ipC = ipC
        self.ipD = ipD
    }

    var description: String {
        return "\(ipA).\(ipB).\(ipC).\(ipD)"
    }
    
    enum Errors: Error {
        case invalidFormat
        case octetOutOfRange
    }
    
    public func advanceBy(_ value: Int) -> IPv4? {
        let newipD = (Int(ipD) + value)
        if newipD <= 255 {
            return IPv4(ipA, ipB, ipC, UInt8(newipD))
        }
        return nil
    }
    
    static func < (lhs: IPv4, rhs: IPv4) -> Bool {
        return lhs.ipD < rhs.ipD
    }

}
