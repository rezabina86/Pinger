//
//  Configure.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import Foundation

func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}
