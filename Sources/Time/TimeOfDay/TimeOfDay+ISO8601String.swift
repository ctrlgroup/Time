//
//  TimeOfDay+ISO8601String.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension TimeOfDay {

  init(iso8601String: String) throws {
    var components = iso8601String.components(separatedBy: ":")

    guard let hour = components.shift()?.asIntFromAsciiRepresentation() else {
      throw TimeOfDayError.invalidISO8601String
    }

    let minute = components.shift()?.asIntFromAsciiRepresentation() ?? 0
    let second = components.shift()?.asIntFromAsciiRepresentation() ?? 0

    try self.init(hour: hour, minute: minute, second: second)
  }

  func iso8601StringRepresentation(includeSeconds: Bool? = nil) -> String {
    let includeSeconds = includeSeconds ?? (second != 0)
    if includeSeconds {
      return String(format: "%02d", hour) + ":" +
        String(format: "%02d", minute) + ":" +
        String(format: "%02d", second)
    } else {
      return String(format: "%02d", hour) + ":" +
        String(format: "%02d", minute)
    }
  }

  func iso8601StringRepresentationWithTimeZone(using timestamp: Timestamp, includeSeconds: Bool = true) -> String {
    let timeString = iso8601StringRepresentation(includeSeconds: includeSeconds)

    if timestamp.timeZone == .utc {
      return timeString + "Z"
    } else {
      return timeString + timestamp.timeZone.iso8601Representation(on: timestamp.date)
    }
  }
}

private extension TimeZone {
  func iso8601Representation(on date: Date) -> String {
    let seconds = secondsFromGMT(for: date)
    let minutes = (abs(seconds) / 60) % 60
    let hours = abs(seconds) / 60 / 60
    let numberFormatter = NumberFormatter()
    numberFormatter.minimumIntegerDigits = 2
    let hoursString = numberFormatter.string(from: NSNumber(value: hours))!
    let minutesString = numberFormatter.string(from: NSNumber(value: minutes))!
    let symbol: Character
    if seconds > 0 {
      symbol = "+"
    } else {
      symbol = "-"
    }
    return "\(symbol)\(hoursString):\(minutesString)"
  }
}
