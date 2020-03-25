//
//  Router.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation
import GBPing

public protocol RouterDelegate: class {
    func router(_ summary: PingSummary?, _ error: PingError?)
}

class Router<PingerSetup: PingerSetupType>: NSObject, PingRouter, GBPingDelegate {
    
    private var pinger: GBPing?
    weak var delegate: RouterDelegate?
    
    func start(_ setup: PingerSetup) {
        pinger = GBPing()
        pinger?.host = setup.host
        pinger?.timeout = setup.timeOut
        pinger?.pingPeriod = setup.pingPeriod
        pinger?.delegate = self
        pinger?.setup { [weak self] (success, error) in
            if success {
                self?.pinger?.startPinging()
            } else {
                self?.delegate?.router(nil, PingError.setupError)
            }
        }
    }
    
    func cancel() {
        pinger?.stop()
        pinger?.delegate = nil
        pinger = nil
    }
    
    func ping(_ pinger: GBPing, didFailWithError error: Error) {
        delegate?.router(nil, .failed)
    }
    
    func ping(_ pinger: GBPing, didTimeoutWith summary: GBPingSummary) {
        delegate?.router(PingSummary(host: summary.host, isReachable: false), .timedOut)
    }
    
    func ping(_ pinger: GBPing, didReceiveReplyWith summary: GBPingSummary) {
        delegate?.router(PingSummary(host: summary.host, isReachable: true), nil)
    }
    
    func ping(_ pinger: GBPing, didFailToSendPingWith summary: GBPingSummary, error: Error) {
        delegate?.router(PingSummary(host: summary.host, isReachable: false), .failedToSend)
    }
    
    func ping(_ pinger: GBPing, didReceiveUnexpectedReplyWith summary: GBPingSummary) {
        delegate?.router(PingSummary(host: summary.host, isReachable: false), .unexpectedReply)
    }

}
