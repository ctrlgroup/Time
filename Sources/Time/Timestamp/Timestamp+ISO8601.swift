//
//  Timestamp+ISO8601.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension Timestamp {

  private static let iso8601DateFormatter = ISO8601DateFormatter()

  enum Error: Swift.Error {
    case invalidISO8601String
  }

  init(iso8601String: String, timeZone: TimeZone) throws {
    guard let date = Self.iso8601DateFormatter.date(from: iso8601String) else {
      throw Timestamp.Error.invalidISO8601String
    }
    self.init(date: date, timeZone: timeZone)
  }

  var iso8601StringRepresentation: String {
    let timeString = timeOfDay.iso8601StringRepresentationWithTimeZone(using: self)
    return day.iso8601StringRepresentation + "T" + timeString
  }
}
