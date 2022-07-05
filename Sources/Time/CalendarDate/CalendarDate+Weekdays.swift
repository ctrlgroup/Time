//
//  CalendarDate+Weekdays.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension CalendarDate {
  func previous(weekday: DayOfWeek) -> CalendarDate {
    let currentDayOfWeek = self.dayOfWeek.dayIndex
    let difference = (weekday.dayIndex - currentDayOfWeek - 7) % 7
    if difference == 0 {
      return self - 7
    }
    return self + Int(difference)
  }

  func next(weekday: DayOfWeek) -> CalendarDate {
    return (self + 7).previous(weekday: weekday)
  }

  func weekdayInCurrentWeek(_ weekday: DayOfWeek) -> CalendarDate {
    let currentDayOfWeek = self.dayOfWeek.dayIndex
    let difference = (weekday.dayIndex - currentDayOfWeek + 7) % 7
    if difference == 0 {
      return self
    } else if (currentDayOfWeek + difference) >= 7 {
      return self + Int(difference - 7)
    } else {
      return self + Int(difference)
    }
  }
}
