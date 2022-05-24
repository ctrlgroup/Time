//
//  CalendarDateRangeSegmenter.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public class CalendarDateRangeSegmenter {

  public let dateRange: CalendarDateRange
  public let segmentSize: Int
  private var totalNumberOfDays: Int { return dateRange.count }
  private var numberOfSegments: Int { return Int( ceil( Double(totalNumberOfDays) / Double(segmentSize) ) ) }

  public init(dateRangeToSegment dateRange: CalendarDateRange, intoSegmentsOfSize segmentSize: Int) {
    self.dateRange = dateRange
    self.segmentSize = segmentSize
  }

  public func divideDateRange() -> [CalendarDateRange] {
    return (0..<numberOfSegments).map(rangeForSegmentAtIndex)
  }

  private func rangeForSegmentAtIndex(_ index: Int) -> CalendarDateRange {
    return CalendarDateRange(firstDate: firstDateForSegmentAtIndex(index),
                             lastIncludedDate: lastDateForSegmentAtIndex(index))
  }

  private func firstDateForSegmentAtIndex(_ index: Int) -> CalendarDate {
    guard index != 0 else { return dateRange.startDate }
    let interval = segmentSize * (numberOfSegments - index)
    return dateRange.lastIncludedDate - (interval - 1)
  }

  private func lastDateForSegmentAtIndex(_ index: Int) -> CalendarDate {
    return firstDateForSegmentAtIndex(index + 1) - 1
  }
}
