//
//  CalendarDate+StringFormatting.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension CalendarDate {

  /// Caches commonly used date formatters for performance
  private static var dateFormatters: [DateFormatter.Style: DateFormatter] = [:]

  func string(withFormat format: String, locale: Locale = .current) -> String {
    let dateFormatter = createDateFormatter(locale: locale)
    dateFormatter.setLocalizedDateFormatFromTemplate(format)
    return dateFormatter.string(from: self)
  }

  func string(withStyle style: DateFormatter.Style,
              locale: Locale = .current,
              doesRelativeDateFormatting: Bool = false) -> String {
    let dateFormatter = self.dateFormatter(for: style, locale: locale)
    dateFormatter.doesRelativeDateFormatting = doesRelativeDateFormatting
    return dateFormatter.string(from: self)
  }

  private func dateFormatter(for style: DateFormatter.Style, locale: Locale) -> DateFormatter {
    if let dateFormatter = CalendarDate.dateFormatters[style] {
      dateFormatter.locale = locale
      return dateFormatter
    }

    let dateFormatter = createDateFormatter(locale: locale)
    dateFormatter.dateStyle = style
    CalendarDate.dateFormatters[style] = dateFormatter
    return dateFormatter
  }

  private func createDateFormatter(locale: Locale) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .utc
    dateFormatter.timeStyle = .none
    dateFormatter.locale = locale
    return dateFormatter
  }
}

public extension DateFormatter {
  func string(from calendarDate: CalendarDate) -> String {
    return string(from: calendarDate.dateInTimeZone(timeZone: timeZone))
  }
}
