//
//  CalendarDate.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public enum CalendarDateError: LocalizedError, Equatable {

  case malformedDate(day: Int, month: Int, year: Int)

  public var errorDescription: String? {
    switch self {
    case .malformedDate(let day, let month, let year):
      return NSLocalizedString("Date is not valid \(day)/\(month)/\(year).",
                               comment: "Error Message")
    }
  }
}

/// Describes a day in the Gregorian calendar, independant of time zone
public struct CalendarDate {
  public let daysSinceReferenceDay: Int

  public init(daysSinceReferenceDay: Int) {
    self.daysSinceReferenceDay = daysSinceReferenceDay
  }
}

extension CalendarDate: CustomDebugStringConvertible {
  public var debugDescription: String {
    // ctrl_group:disable:next localization
    return "<CalendarDate: \(iso8601StringRepresentation)>"
  }
}

// MARK: - Gregorian Calendar
public extension CalendarDate {
  static var gregorianCalendar: Calendar { return Calendar.gregorianInUTC }
  var gregorianCalendar: Calendar { return CalendarDate.gregorianCalendar }
}

// MARK: - Reference Date
private extension CalendarDate {
  private static let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
  private static let referenceDateComponents = gregorianCalendar.dateComponents(in: .utc, from: referenceDate)
}

// MARK: - Date Components
public extension CalendarDate {

  var intRepresentation: Int32 { Int32(daysSinceReferenceDay) }

  var day: Int { dateComponents.day! }
  var month: Int { dateComponents.month! }
  var year: Int { dateComponents.year! }

  private var dateComponents: DateComponents {
    let date = gregorianCalendar.date(byAdding: .day,
                                      value: Int(intRepresentation),
                                      to: Self.referenceDate)!
    return gregorianCalendar.dateComponents(in: gregorianCalendar.timeZone, from: date)
  }

  var dayOfWeek: DayOfWeek {
    let date = self.date(in: .utc)
    let completeDateComponents = gregorianCalendar.dateComponents([.weekday], from: date)
    return DayOfWeek(dateComponents: completeDateComponents)!
  }
}

public extension CalendarDate {

  init(daysSinceReferenceDay: Int32) {
    self.init(daysSinceReferenceDay: Int(daysSinceReferenceDay))
  }

  init(day: Int, month: Int, year: Int) throws {
    let dateComponents = DateComponents(calendar: Self.gregorianCalendar,
                                        year: year,
                                        month: month,
                                        day: day)

    guard dateComponents.isValidDate else {
      throw CalendarDateError.malformedDate(day: day, month: month, year: year)
    }

    self.init(dateComponents: dateComponents)
  }

  init(date: Date, timeZone: TimeZone) {
    let dateComponents = CalendarDate.gregorianCalendar.dateComponents(in: timeZone, from: date)
    try! self.init(day: dateComponents.day!,
                   month: dateComponents.month!,
                   year: dateComponents.year!)
  }

  // Important! Date components used here must use the gregorian calendar (and time zone)
  private init(dateComponents: DateComponents) {
    let daysSinceReferenceDate = Self.gregorianCalendar.dateComponents([.day],
                                                                       from: Self.referenceDateComponents,
                                                                       to: dateComponents).day!
    self.init(daysSinceReferenceDay: daysSinceReferenceDate)
  }
}

// MARK: - Conversion to other representations
public extension CalendarDate {
  func date(in timezone: TimeZone) -> Date {
    var dateComponents = self.dateComponents
    dateComponents.timeZone = timezone
    return dateComponents.date!
  }
}

// MARK: - Adding days to a date
public extension CalendarDate {

  static func + (_ lhs: CalendarDate, rhs: Int) -> CalendarDate {
    return lhs.calendarDate(byAddingDays: rhs)
  }

  static func - (_ lhs: CalendarDate, rhs: Int) -> CalendarDate {
    return lhs.calendarDate(byAddingDays: -rhs)
  }

  static func += ( left: inout CalendarDate, right: Int) {
    left = left.calendarDate(byAddingDays: right)
  }

  func calendarDate(byAddingDays numberOfDays: Int) -> CalendarDate {
    return CalendarDate(daysSinceReferenceDay: daysSinceReferenceDay + numberOfDays)
  }
}

// MARK: - Comparitors
extension CalendarDate: Comparable {
  public static func < (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
    return lhs.isBefore(rhs)
  }

  public func isBefore(_ otherDate: CalendarDate) -> Bool {
    return daysSinceReferenceDay < otherDate.daysSinceReferenceDay
  }

  public func isAfter(_ otherDate: CalendarDate) -> Bool {
    return self > otherDate
  }

  public static func - (_ lhs: CalendarDate, rhs: CalendarDate) -> Int {
    return rhs.distance(to: lhs)
  }
}

// MARK: - Stridable
extension CalendarDate: Strideable {
  public func advanced(by n: Int) -> CalendarDate {
    return self + n
  }

  public func distance(to other: CalendarDate) -> Int {
    return other.daysSinceReferenceDay - daysSinceReferenceDay
  }
}

// MARK: -
extension CalendarDate: Equatable {}
extension CalendarDate: Hashable {}
extension CalendarDate: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let iso8601String = try container.decode(String.self)
    try self.init(iso8601String: iso8601String)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(iso8601StringRepresentation)
  }
}
