//
//  PingerTests.swift
//  PingerTests
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import XCTest
@testable import Pinger

class PingerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        testIPAdvance()
        testPingerRange()
    }
    
    func testPingerRange() {
        var a = PingerRange(ip: IPv4(192, 168, 1, 34), size: 3)
        XCTAssertEqual(a.next(), [IPv4(192, 168, 1, 1), IPv4(192, 168, 1, 2), IPv4(192, 168, 1, 3)])
        XCTAssertEqual(a.next(), [IPv4(192, 168, 1, 4), IPv4(192, 168, 1, 5), IPv4(192, 168, 1, 6)])
        XCTAssertEqual(a.next(), [IPv4(192, 168, 1, 7), IPv4(192, 168, 1, 8), IPv4(192, 168, 1, 9)])
        
        var b = PingerRange(ip: IPv4(192, 168, 1, 34), size: 10)
        while let next = b.next() {
            if next.count == 5 {
                XCTAssertEqual(next, [IPv4(192, 168, 1, 251), IPv4(192, 168, 1, 252), IPv4(192, 168, 1, 253), IPv4(192, 168, 1, 254), IPv4(192, 168, 1, 255)])
            }
        }
    }
    
    func testIPAdvance() {
        let ip = IPv4(192, 168, 1, 254)
        XCTAssertEqual(ip.advanceBy(1), IPv4(192, 168, 1, 255))
        XCTAssertEqual(ip.advanceBy(2), nil)
    }
    
    func testSortFunction() {
        let summary = NetworkScannerResult()
        summary.results = [PingSummary(host: "192.168.1.30", isReachable: false), PingSummary(host: "192.168.1.5", isReachable: true), PingSummary(host: "192.168.1.254", isReachable: true), PingSummary(host: "192.168.1.1", isReachable: false)]
        
        summary.sort(by: .reachability)
        XCTAssertEqual(summary.results, [PingSummary(host: "192.168.1.5", isReachable: true), PingSummary(host: "192.168.1.254", isReachable: true), PingSummary(host: "192.168.1.1", isReachable: false), PingSummary(host: "192.168.1.30", isReachable: false)])
        
        summary.sort(by: .ip)
        XCTAssertEqual(summary.results, [PingSummary(host: "192.168.1.1", isReachable: false), PingSummary(host: "192.168.1.5", isReachable: true), PingSummary(host: "192.168.1.30", isReachable: false), PingSummary(host: "192.168.1.254", isReachable: true)])
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
