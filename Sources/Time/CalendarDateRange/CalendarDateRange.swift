//
//  CalendarDateRange.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public typealias CalendarDateRange = Range<StridableCalendarDate>

public struct StridableCalendarDate: Strideable {

  let calendarDate: CalendarDate

  public func distance(to other: StridableCalendarDate) -> Int {
    return Int(calendarDate.distanceTo(other: other.calendarDate))
  }

  public func advanced(by n: Int) -> Self {
    return (calendarDate + n).stridable
  }
}

extension CalendarDate {
  var stridable: StridableCalendarDate {
    StridableCalendarDate(calendarDate: self)
  }

  public static func ..< (_ lhs: CalendarDate, _ rhs: CalendarDate) -> CalendarDateRange {
    return lhs.stridable ..< rhs.stridable
  }
}

public extension CalendarDateRange {

  var startDate: CalendarDate { lowerBound.calendarDate }
  var endDate: CalendarDate { upperBound.calendarDate }
  var lastIncludedDate: CalendarDate {
    return endDate - 1
  }

  var allCalendarDates: [CalendarDate] {
    map { $0.calendarDate }
  }

  init(startDate: CalendarDate, endDate: CalendarDate) {
    self.init(uncheckedBounds: (startDate.stridable, endDate.stridable))
  }

  init(firstDate: CalendarDate, lastIncludedDate: CalendarDate) {
    let endDate = lastIncludedDate + 1
    self.init(startDate: firstDate, endDate: endDate)
  }

  init(_ closedRange: ClosedRange<StridableCalendarDate>) {
    self.init(firstDate: closedRange.lowerBound.calendarDate,
              lastIncludedDate: closedRange.upperBound.calendarDate)
  }
}

// MARK: - Int indexed collection
public extension CalendarDateRange {

  var startIndex: Int { return 0 }

  func firstIndex(of element: CalendarDate) -> Int? {
    guard contains(element.stridable) else {
      return nil
    }
    return element - startDate
  }

  subscript(index: Int) -> CalendarDate {
    precondition(index < count)
    return startDate + index
  }
}
