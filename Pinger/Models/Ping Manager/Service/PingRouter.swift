//
//  PingRouter.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

protocol PingRouter: class {
    associatedtype PingerSetup: PingerSetupType
    func start(_ setup: PingerSetup)
    func cancel()
}
