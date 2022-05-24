//
//  Timestamp+Arithmetic.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension Timestamp {
  static func + (_ lhs: Timestamp, _ rhs: TimeInterval) -> Timestamp {
    let newDate = lhs.date.addingTimeInterval(rhs)
    return Timestamp(date: newDate, timeZone: lhs.timeZone)
  }

  static func - (_ lhs: Timestamp, _ rhs: Timestamp) -> TimeInterval {
    return lhs.date.timeIntervalSince(rhs.date)
  }
}
