//
//  CalendarDate.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public typealias CalendarDate = TimeKMM.CalendarDate

//extension CalendarDate: CustomDebugStringConvertible {
//  public var debugDescription: String {
//    // ctrl_group:disable:next localization
//    return "<CalendarDate: \(iso8601StringRepresentation)>"
//  }
//}

// MARK: - Gregorian Calendar
public extension CalendarDate {
  static var gregorianCalendar: Calendar { return Calendar.gregorianInUTC }
  var gregorianCalendar: Calendar { return CalendarDate.gregorianCalendar }
}

// MARK: - Adding days to a date
public extension CalendarDate {

  static func + (_ lhs: CalendarDate, rhs: Int) -> CalendarDate {
    return lhs.plus(increment: Int32(rhs))
  }

  static func - (_ lhs: CalendarDate, rhs: Int) -> CalendarDate {
    return lhs.minus(increment: Int32(rhs))
  }

  static func += ( left: inout CalendarDate, right: Int) {
    left = left.plus(increment: Int32(right))
  }
}

// MARK: - Comparitors
extension CalendarDate: Comparable {
  public static func < (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
    return lhs.isBefore(other: rhs)
  }

  public static func - (_ lhs: CalendarDate, rhs: CalendarDate) -> Int {
    return Int(rhs.distanceTo(other: lhs))
  }
}
