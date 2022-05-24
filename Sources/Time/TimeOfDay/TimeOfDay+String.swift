//
//  TimeOfDay+String.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension TimeOfDay {

  struct StringStyle {
    public let size: StringSize
    public let hourStyle: StringHourStyle

    public init(size: StringSize, hourStyle: StringHourStyle) {
      self.size = size
      self.hourStyle = hourStyle
    }

    public static var `default`: StringStyle {
      return StringStyle(size: .short, hourStyle: .localeDefault)
    }
  }

  enum StringHourStyle {
    case twelveHour, twentyFourHour, localeDefault
  }

  /// This represents a subset of the DateFormatter.Style
  ///
  /// Distinctly; it doesn't contains .none as this makes no sense without a date aspect,
  /// and doesn't contain .long or .full as these don't makes sense without a time zone aspect.
  enum StringSize {
    case short, medium
    public var timeStyle: DateFormatter.Style {
      switch self {
      case .short: return .short
      case .medium: return .medium
      }
    }
  }

  init?(string: String, style: (StringSize, StringHourStyle), locale: Locale = .current) {
    let style = StringStyle(size: style.0, hourStyle: style.1)
    self.init(string: string, style: style, locale: locale)
  }

  init?(string: String, style: StringStyle = .default, locale: Locale = .current) {
    let dateFormatter = TimeOfDay.dateFormatter(forStyle: style, locale: locale)
    guard let result = dateFormatter.timeOfDay(from: string) else {
      return nil
    }
    self = result
  }

  func string(style: (StringSize, StringHourStyle), locale: Locale = .current) -> String {
    let style = StringStyle(size: style.0, hourStyle: style.1)
    return string(style: style, locale: locale)
  }

  func string(style: StringStyle = .default, locale: Locale = .current) -> String {
    let dateFormatter = TimeOfDay.dateFormatter(forStyle: style, locale: locale)
    return dateFormatter.string(from: self)
  }

  private static func dateFormatter(forStyle style: StringStyle, locale: Locale) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = locale
    switch (style.hourStyle, style.size) {
    case (.localeDefault, let size):
      dateFormatter.dateStyle = .none
      dateFormatter.timeStyle = size.timeStyle
    case (.twelveHour, .short):
      dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm a")
    case (.twelveHour, .medium):
      dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm:ss a")
    case (.twentyFourHour, .short):
      dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
    case (.twentyFourHour, .medium):
      dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm:ss")
    }
    return dateFormatter
  }
}

public extension DateFormatter {
  func string(from timeOfDay: TimeOfDay) -> String {
    let arbitraryCalendarDate = CalendarDate(date: Date(), timeZone: .utc)
    let dateTime = DateTime(calendarDate: arbitraryCalendarDate, timeOfDay: timeOfDay)
    return string(from: dateTime.date(in: timeZone))
  }

  func timeOfDay(from string: String) -> TimeOfDay? {
    guard let date = date(from: string) else { return nil }
    return TimeOfDay(date: date, timeZone: timeZone)
  }
}
