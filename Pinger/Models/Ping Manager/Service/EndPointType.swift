//
//  EndPointType.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

protocol PingerSetupType {
    var host: String { get }
    var timeOut: TimeInterval { get }
    var pingPeriod: TimeInterval { get }
}
