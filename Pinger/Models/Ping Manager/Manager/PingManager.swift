//
//  PingManager.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import GBPing

class PingManager: NSObject {
    
    typealias completionHandler = (_ summary: PingSummary?, _ error: PingError?) -> Void
    
    private let router = Router<PingSetup>()
    private var completion: completionHandler
    private let numberOfAttempts: Int = 3
    private var errorCounter: Int = 1
    
    init(completion: @escaping completionHandler) {
        self.completion = completion
    }
    
    public func startPing(_ setup: PingSetup) {
        router.delegate = self
        router.start(setup)
    }
    
    private func checkingAttemps(_ summary: PingSummary?, _ error: PingError?) {
        guard error != .failed else {
            router.cancel()
            completion(nil, error)
            return
        }
        errorCounter += 1
        if errorCounter > numberOfAttempts {
            router.cancel()
            completion(summary, error)
        }
    }
    
}

extension PingManager: RouterDelegate {
    
    func router(_ summary: PingSummary?, _ error: PingError?) {
        if let error = error {
            switch error {
            case .failed:
                router.cancel()
                completion(nil, error)
            default:
                checkingAttemps(summary, error)
            }
        } else {
            router.cancel()
            completion(summary, error)
        }
    }

}
