//
//  TimeOfDay.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public enum TimeOfDayError: LocalizedError, Equatable {

  case malformedTime(hour: Int, minute: Int, second: Int)
  case invalidISO8601String

  public var errorDescription: String? {
    switch self {
    case .malformedTime(let hour, let minute, let second):
      return NSLocalizedString("Time is not valid \(hour)/\(minute)/\(second).", comment: "Error Message")
    case .invalidISO8601String:
      return NSLocalizedString("Time is not a valid ISO 8601 string.", comment: "Error message")
    }
  }
}

public struct TimeOfDay {

  private static var gregorianCalendar: Calendar { Calendar.gregorianInUTC }

  public let hour: Int
  public let minute: Int
  public let second: Int

  public enum TimeOfDayLabel: String {
    case morning
    case afternoon
    case evening
  }

  public init(hour: Int, minute: Int, second: Int) throws {
    guard TimeOfDay.isValidTime(hour: hour, minute: minute, second: second) else {
      throw TimeOfDayError.malformedTime(hour: hour, minute: minute, second: second)
    }

    self.hour = hour
    self.minute = minute
    self.second = second
  }
}

public extension TimeOfDay {

  var label: String {
    if hour < 12 {
      return TimeOfDayLabel.morning.rawValue
    } else if hour < 18 {
      return TimeOfDayLabel.afternoon.rawValue
    } else {
      return TimeOfDayLabel.evening.rawValue
    }
  }

  init(date: Date, timeZone: TimeZone) {
    let dateComponents = TimeOfDay.gregorianCalendar.dateComponents(in: timeZone, from: date)
    try! self.init(hour: dateComponents.hour!,
                   minute: dateComponents.minute!,
                   second: dateComponents.second!)
  }

  private static func isValidTime(hour: Int, minute: Int, second: Int) -> Bool {
    let dateComponents = DateComponents(calendar: gregorianCalendar,
                                        hour: hour,
                                        minute: minute,
                                        second: second)
    return dateComponents.isValidDate
  }

  init(secondsSinceMidnight: Int) throws {
    let seconds = secondsSinceMidnight % 60
    let minutes = ((secondsSinceMidnight - seconds) / 60) % 60
    let hours = ((secondsSinceMidnight - minutes - seconds) / (60 * 60))
    self = try .init(hour: hours, minute: minutes, second: seconds)
  }

  private var secondsSinceMidnight: Int {
    let hourInSeconds = hour * 60 * 60
    let minuteInSeconds = minute * 60
    return hourInSeconds + minuteInSeconds + second
  }
}

extension TimeOfDay: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let iso8601String = try container.decode(String.self)
    try self.init(iso8601String: iso8601String)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(self.iso8601StringRepresentation())
  }
}

extension TimeOfDay: Equatable {}

extension TimeOfDay: Hashable {}

extension TimeOfDay: Comparable {
  public static func < (lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
    return lhs.secondsSinceMidnight < rhs.secondsSinceMidnight
  }
}

infix operator ⁝ : MultiplicationPrecedence

public extension Int {
  static func ⁝ (left: Int, right: Int) -> TimeOfDay {
    return try! TimeOfDay(hour: left, minute: right, second: 0)
  }
}

public extension TimeOfDay {
  static func ⁝ (left: TimeOfDay, right: Int) -> TimeOfDay {
    return try! TimeOfDay(hour: left.hour, minute: left.minute, second: right)
  }
}

public extension TimeOfDay {
  static func + (lhs: TimeOfDay, rhs: TimeInterval) -> TimeOfDay {
    let seconds = (lhs.secondsSinceMidnight + Int(rhs)) % Int(.day)
    if seconds < 0 {
      return try! TimeOfDay(secondsSinceMidnight: Int(.day) + seconds)
    } else {
      return try! TimeOfDay(secondsSinceMidnight: seconds)
    }
  }

  static func - (lhs: TimeOfDay, rhs: TimeInterval) -> TimeOfDay {
    return lhs + (-rhs)
  }
}

public extension TimeOfDay {
  static func - (lhs: TimeOfDay, rhs: TimeOfDay) -> TimeInterval {
    return Double(lhs.secondsSinceMidnight - rhs.secondsSinceMidnight)
  }
}

public extension TimeOfDay {
  var hourInTwelveHourClock: Int {
    guard hour != 12 else {
      return hour
    }
    guard hour != 0 else {
      return 12
    }
    return hour % 12
  }

  func period(locale: Locale? = nil) -> String {
    let calendar = Calendar.gregorianInUTC(withLocale: locale)
    if hour < 12 {
      return calendar.amSymbol
    } else {
      return calendar.pmSymbol
    }
  }
}
