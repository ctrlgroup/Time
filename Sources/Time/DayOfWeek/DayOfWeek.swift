//
//  Weekday.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import TimeKMM

public typealias DayOfWeek = TimeKMM.Kotlinx_datetimeDayOfWeek

extension DateComponents {
  var dayOfWeek: DayOfWeek? {
    DayOfWeekKt.dayOfWeek(self)
  }
}
