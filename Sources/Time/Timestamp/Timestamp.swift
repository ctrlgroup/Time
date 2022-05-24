//
//  Timestamp.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Timestamp: Hashable {
  public let date: Date
  public let timeZone: TimeZone

  public init(date: Date, timeZone: TimeZone) {
    self.date = date
    self.timeZone = timeZone
  }
}

// Due to inaccuracies in floating point arithmetic this
// compares whether the dates are within a millisecond of one another
extension Timestamp: Equatable {
  public static func == (_ lhs: Timestamp, _ rhs: Timestamp) -> Bool {
    return lhs.timeZone == rhs.timeZone &&
      abs(lhs.date.timeIntervalSinceReferenceDate - rhs.date.timeIntervalSinceReferenceDate) < 0.001
  }
}

public extension Timestamp {
  var dateTime: DateTime {
    return DateTime(calendarDate: day, timeOfDay: timeOfDay)
  }

  var day: CalendarDate {
    return CalendarDate(date: date, timeZone: timeZone)
  }

  var timeOfDay: TimeOfDay {
    return TimeOfDay(date: date, timeZone: timeZone)
  }
}
