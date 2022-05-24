//
//  Weekday.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public enum DayOfWeek: Equatable, CaseIterable {
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  case sunday

  // https://developer.apple.com/documentation/foundation/nsdatecomponents/1410442-weekday
  public init?(dateComponents: DateComponents) {
    guard let index = dateComponents.weekday, index > 0 && index <= 7 else { return nil }
    // Apple use Sunday = 1
    let correctedIndex = (index + 5) % 7
    self = DayOfWeek.allCases[correctedIndex]
  }

  public var dateComponentsCompatibleWeekday: Int {
    let correctedIndex = DayOfWeek.allCases.firstIndex(of: self)!
    return (correctedIndex + 1) % 7 + 1
  }

  public var dayIndex: Int {
    DayOfWeek.allCases.firstIndex(of: self)!
  }

  public func veryShortWeekdaySymbol(locale: Locale = .current) -> String {
    let calendar = Calendar.gregorianInUTC(withLocale: locale)
    return calendar.veryShortWeekdaySymbols[dateComponentsCompatibleWeekday - 1]
  }

  public func shortStandaloneWeekdaySymbol(locale: Locale = .current) -> String {
    let calendar = Calendar.gregorianInUTC(withLocale: locale)
    return calendar.shortStandaloneWeekdaySymbols[dateComponentsCompatibleWeekday - 1]
  }
}
