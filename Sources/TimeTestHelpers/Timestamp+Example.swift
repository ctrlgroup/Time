//
//  Timestamp+Example.swift
//  TimeTestHelpers
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import Time

public extension Timestamp {
  static let example: Timestamp = Self.init(date: Date(timeIntervalSince1970: 1575987330),
                                            timeZone: .utc)

  init(day: CalendarDate = .example, time: TimeOfDay = 12⁝00, timeZone: TimeZone = .utc) {
    let dateTime = DateTime(calendarDate: day, timeOfDay: time)
    self.init(date: dateTime.date(in: timeZone), timeZone: timeZone)
  }
}
