//
//  Date.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension Date {

  static func - (_ lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince(rhs)
  }

  func numberOfDays(before endDate: Date) -> Int {
    let interval = endDate - self
    return Int( (interval / TimeInterval.day).rounded(.down) )
  }

  func withHour(hour: Int, minute: Int, second: Int, timeZone: TimeZone? = nil) -> Date {
    var calendar = Calendar.current
    if let timeZone = timeZone {
      calendar.timeZone = timeZone
    }
    let componentFlags = Set<Calendar.Component>([.year, .month, .day])
    var components = calendar.dateComponents(componentFlags, from: self)
    components.hour = hour
    components.minute = minute
    components.second = second
    return calendar.date(from: components)!
  }

  func addDays(days: Int) -> Date {
    let calendar = Calendar.current
    var components = DateComponents()
    components.day = days
    return calendar.date(byAdding: components, to: self)!
  }
}
