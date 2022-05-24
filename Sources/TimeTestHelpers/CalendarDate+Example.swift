//
//  CalendarDate+Example.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import Time

public extension CalendarDate {
  static var example = try! CalendarDate(day: 1, month: 2, year: 2003)
  static var example1 = try! CalendarDate(day: 1, month: 2, year: 2003)
  static var example2 = try! CalendarDate(day: 2, month: 2, year: 2003)
  static var example3 = try! CalendarDate(day: 3, month: 2, year: 2003)

  static let jan27th2020 = try! CalendarDate(day: 27, month: 1, year: 2020)
  static let march4th2020 = try! CalendarDate(day: 4, month: 3, year: 2020)
  static let april1st2020 = try! CalendarDate(day: 1, month: 4, year: 2020)
  static let april25th2020 = try! CalendarDate(day: 25, month: 4, year: 2020)
  static let june1st2020 = try! CalendarDate(day: 1, month: 6, year: 2020)
  static let june1st2050 = try! CalendarDate(day: 1, month: 6, year: 2050)
}
