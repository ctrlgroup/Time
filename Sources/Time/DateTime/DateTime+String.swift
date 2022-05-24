//
//  DateTime+String.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension DateTime {
  func iso8601StringRepresentation(timeZone: TimeZone?) -> String {
    let timeString: String

    if let timeZone = timeZone {
      let timestamp = Timestamp(date: date(in: timeZone), timeZone: timeZone)
      timeString = timeOfDay.iso8601StringRepresentationWithTimeZone(using: timestamp)
    } else {
      timeString = timeOfDay.iso8601StringRepresentation()
    }

    return calendarDate.iso8601StringRepresentation + "T" + timeString
  }
}
