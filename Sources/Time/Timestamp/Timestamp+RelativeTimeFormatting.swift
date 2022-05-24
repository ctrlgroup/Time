//
//  Timestamp+RelativeTimeFormatting.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension Timestamp {
  func localisedStringRelativeToToday(locale: Locale) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = locale
    dateFormatter.dateStyle = .medium
    dateFormatter.doesRelativeDateFormatting = true
    return dateFormatter.string(from: date)
  }
}
