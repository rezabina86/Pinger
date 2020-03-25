//
//  PingError.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

public enum PingError: Error {
    case timedOut
    case failed
    case failedToSend
    case unexpectedReply
    case setupError
}
