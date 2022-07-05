//
//  CalendarDateRange.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public typealias CalendarDateRange = Range<CalendarDate>

public extension CalendarDateRange {

  var startDate: CalendarDate { lowerBound }
  var endDate: CalendarDate { upperBound }
  var lastIncludedDate: CalendarDate {
    return endDate - 1
  }

  init(startDate: CalendarDate, endDate: CalendarDate) {
    self.init(uncheckedBounds: (startDate, endDate))
  }

  init(firstDate: CalendarDate, lastIncludedDate: CalendarDate) {
    let endDate = lastIncludedDate + 1
    self.init(startDate: firstDate, endDate: endDate)
  }

  init(_ closedRange: ClosedRange<CalendarDate>) {
    self.init(firstDate: closedRange.lowerBound, lastIncludedDate: closedRange.upperBound)
  }
}

// MARK: - Int indexed collection
public extension CalendarDateRange {

  var startIndex: Int { return 0 }

  func firstIndex(of element: CalendarDate) -> Int? {
    guard contains(element) else {
      return nil
    }
    return element - startDate
  }

//  subscript(index: Int) -> CalendarDate {
//    precondition(index < count)
//    return startDate + index
//  }
}
