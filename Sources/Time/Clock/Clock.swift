//
//  Clock.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public class Clock {

  public private(set) var timeZone: TimeZone

  public let timeZoneProvider: TimeZoneProvider
  public let dateFactory: DateFactory

  public init(timeZoneProvider: TimeZoneProvider,
              dateFactory: DateFactory) {
    self.dateFactory = dateFactory
    self.timeZoneProvider = timeZoneProvider
    self.timeZone = timeZoneProvider.currentTimeZone()
  }

  public func readDateTime() -> DateTime {
    let date = self.date()
    let calendarDate = CalendarDate(date: date, timeZone: timeZone)
    let timeOfDay = TimeOfDay(date: date, timeZone: timeZone)
    return DateTime(calendarDate: calendarDate, timeOfDay: timeOfDay)
  }

  public func readTimestamp() -> Timestamp {
    return Timestamp(date: date(), timeZone: timeZone)
  }

  public func refreshTimeZone() {
    timeZone = timeZoneProvider.currentTimeZone()
  }

  private func date() -> Date {
    return dateFactory.currentDate()
  }
}
