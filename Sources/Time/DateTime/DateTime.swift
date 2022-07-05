//
//  DateTime.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct DateTime: Equatable, Hashable {
  public let calendarDate: CalendarDate
  public let timeOfDay: TimeOfDay

  public init(calendarDate: CalendarDate, timeOfDay: TimeOfDay) {
    self.calendarDate = calendarDate
    self.timeOfDay = timeOfDay
  }
}

public extension DateTime {

  init(date: Date, timeZone: TimeZone) {
    self.calendarDate = CalendarDate(date: date, timeZone: timeZone)
    self.timeOfDay = TimeOfDay(date: date, timeZone: timeZone)
  }

  func date(in timeZone: TimeZone = .current) -> Date {
    return dateComponents(withTimeZone: timeZone).date!
  }

  func timestamp(in timezone: TimeZone = .current) -> Timestamp {
    Timestamp(date: date(in: timezone), timeZone: timezone)
  }
}

extension DateTime: Comparable {
  public static func < (lhs: DateTime, rhs: DateTime) -> Bool {
    if lhs.calendarDate == rhs.calendarDate {
      return lhs.timeOfDay < rhs.timeOfDay
    } else {
      return lhs.calendarDate < rhs.calendarDate
    }
  }
}

public extension DateTime {
  func dateComponents(withTimeZone timeZone: TimeZone? = nil) -> DateComponents {
    var calendar: Calendar?
    if let timeZone = timeZone {
      calendar = Calendar.gregorianInUTC
      calendar?.timeZone = timeZone
    }
    return DateComponents(calendar: calendar,
                          timeZone: timeZone,
                          year: Int(calendarDate.year),
                          month: Int(calendarDate.month),
                          day: Int(calendarDate.day),
                          hour: timeOfDay.hour,
                          minute: timeOfDay.minute,
                          second: timeOfDay.second)
  }
}
