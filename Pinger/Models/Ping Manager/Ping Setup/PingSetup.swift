//
//  PingSetup.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

struct PingSetup: PingerSetupType {
    var host: String
    var timeOut: TimeInterval = 1.0
    var pingPeriod: TimeInterval = 0.9
}
