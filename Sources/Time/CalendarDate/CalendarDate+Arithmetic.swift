//
//  CalendarDate+Arithmetic.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension CalendarDate {
  func dateByAdding(_ value: Int, unit: Calendar.Component) -> CalendarDate {
    let resultDate = gregorianCalendar.date(byAdding: unit, value: value, to: dateInTimeZone(timeZone: .utc))!
    return CalendarDate(date: resultDate, timeZone: .utc)
  }
}
