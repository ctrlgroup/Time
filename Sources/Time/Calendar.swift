//
//  Calendar.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension Calendar {

  static let gregorianInUTC: Calendar = gregorianInUTC(withLocale: nil)

  static func gregorianInUTC(withLocale locale: Locale? = nil) -> Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = .utc
    calendar.locale = locale
    return calendar
  }
}
