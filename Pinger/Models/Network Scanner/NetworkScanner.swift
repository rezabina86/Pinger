//
//  NetworkScanner.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-23.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

protocol NetworkScannerDelegate: class {
    func networkScannerDidFinishPing(with result: [PingSummary])
    func networkScannerDelegate(numberOfPinged ip: Int)
}

class NetworkScanner: NSObject {
    
    typealias complitionHandler = (_ success: Bool) -> Void
    
    private let concurrentPingers: Int = 10 //This variable sets the max number of concurrent pingers.
    
    private var isScanning: Bool = false
    private var range: PingerRange?
    private var pingManagers: [PingManager] = []
    private var summary: [PingSummary] = [] {
        willSet { delegate?.networkScannerDelegate(numberOfPinged: newValue.count) }
    }
    
    private var concurrentPingersQueue: DispatchQueue!
    private var concurrentPingersGroup: DispatchGroup!
    
    weak var delegate: NetworkScannerDelegate?
    
    deinit {
        print("Scanner deinited")
    }
    
    public func setup(completion: complitionHandler) {
        guard let ipAddress = UIDevice.current.ipAddress() else {
            completion(false)
            return
        }
        self.range = PingerRange(ip: ipAddress, size: concurrentPingers)
        completion(true)
    }
    
    public func startScanning() {
        isScanning = true
        summary.removeAll()
        pingManagers.removeAll()
        range?.resetRange()
        guard let firstRange = range?.next() else { return }
        scanRange(firstRange)
    }
    
    public func stop() {
        isScanning = false
    }
    
    private func scanRange(_ range: [IPv4]) {
        concurrentPingersQueue = DispatchQueue(label: "com.pinger.queues.concurrent", attributes: .concurrent)
        concurrentPingersGroup = DispatchGroup()
        
        var tempSummary: [PingSummary] = []
        concurrentPingersQueue.async(group: concurrentPingersGroup) { [weak self] in
            guard let `self` = self else { return }
            range.forEach({ [weak self] in
                guard let `self` = self else { return }
                self.concurrentPingersGroup.enter()
                let pingManager = PingManager { [weak self] (summary, _) in
                    guard let `self` = self else { return }
                    if let summary = summary { tempSummary.append(summary) }
                    self.concurrentPingersGroup.leave()
                }
                self.pingManagers.append(pingManager)
                pingManager.startPing(PingSetup(host: $0.description))
            })

        }

        concurrentPingersGroup.notify(queue: concurrentPingersQueue) { [weak self] in
            guard let `self` = self else { return }
            tempSummary.forEach({ self.summary.append($0) })
            self.pingManagers.removeAll()
            if let nextRange = self.range?.next(), self.isScanning {
                self.scanRange(nextRange)
            } else {
                self.delegate?.networkScannerDidFinishPing(with: self.summary)
            }
        }
    }
    
}
