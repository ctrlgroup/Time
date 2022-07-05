//
//  CalendarDate+String.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public enum CalendarDateStringError: LocalizedError, Equatable {

  case malformedString(string: String)

  public var errorDescription: String? {
    switch self {
    case .malformedString(let string):
      return NSLocalizedString("Date String is not valid \(string).", comment: "Error Message")
    }
  }
}

public extension CalendarDate {

  private static let connectDateFormatRegex = "([0-9]{1,2})/([0-9]{1,2})/([0-9]{1,4})"
  private static let iso8601Regex = "([0-9]{1,4})-([0-9]{1,2})-([0-9]{1,2})"

  var connectDateFormatStringRepresentation: String {
    return String(format: "%02d", day) + "/" +
           String(format: "%02d", month) + "/" +
           String(format: "%04d", year)
  }

  var iso8601StringRepresentation: String {
    return String(format: "%04d", year) + "-" +
           String(format: "%02d", month) + "-" +
           String(format: "%02d", day)
  }

  func fullISO8601StringRepresentation(in timeZone: TimeZone) -> String {
    let dateTime = DateTime(calendarDate: self, timeOfDay: 00⁝00)
    return dateTime.iso8601StringRepresentation(timeZone: timeZone)
  }

  convenience init(string: String) throws {

    let match = CalendarDate.regexMatch(for: string, pattern: CalendarDate.connectDateFormatRegex)

    guard CalendarDate.isValidDateString(string, regexMatch: match) else {
      throw CalendarDateStringError.malformedString(string: string)
    }

    let (dayString, monthString, yearString) = CalendarDate.componentsOfDateString(string: string,
                                                                                   fromRegexMatch: match)

    try self.init(day: Int32(Int(dayString)!),
                  month: Int32(Int(monthString)!),
                  year: Int32(Int(yearString)!))
  }

  convenience init(iso8601String string: String) throws {

    let match = CalendarDate.regexMatch(for: string, pattern: CalendarDate.iso8601Regex)

    guard CalendarDate.isValidDateString(string, regexMatch: match) else {
      throw CalendarDateStringError.malformedString(string: string)
    }

    let (yearString, monthString, dayString) = CalendarDate.componentsOfISO8601String(string: string,
                                                                                      fromRegexMatch: match)

    try self.init(day: Int32(Int(dayString)!),
                  month: Int32(Int(monthString)!),
                  year: Int32(Int(yearString)!))
  }

  private static func regexMatch(for string: String, pattern: String) -> NSTextCheckingResult? {
    let regularExpress = try! NSRegularExpression(pattern: pattern, options: [])
    return regularExpress.firstMatch(in: string, options: [], range: string.nsRange)
  }

  private static func isValidDateString(_ string: String, regexMatch: NSTextCheckingResult?) -> Bool {
    guard let matchedRange = regexMatch?.range else {
      return false
    }
    return matchedRange == string.nsRange
  }

  private static func componentsOfDateString(string: String,
                                             fromRegexMatch regexMatch: NSTextCheckingResult?)
    -> (day: String, month: String, year: String) {
      guard let match = regexMatch else { fatalError() }
      return (string[match.range(at: 1)],
              string[match.range(at: 2)],
              string[match.range(at: 3)])
  }

  private static func componentsOfISO8601String(string: String,
                                                fromRegexMatch regexMatch: NSTextCheckingResult?)
    -> (year: String, month: String, day: String) {
      guard let match = regexMatch else { fatalError() }
      return (string[match.range(at: 1)],
              string[match.range(at: 2)],
              string[match.range(at: 3)])
  }

}
