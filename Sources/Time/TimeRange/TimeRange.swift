//
//  TimeRange.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct TimeRange: Equatable {
  public let startTime: TimeOfDay
  public let endTime: TimeOfDay

  public init(startTime: TimeOfDay, endTime: TimeOfDay) {
    self.startTime = startTime
    self.endTime = endTime
  }
}

public extension TimeRange {

  var lastIncludedTime: TimeOfDay? {
    guard startTime != endTime else { return nil }
    return endTime - 1
  }

  private var rangeFallsOverMidnight: Bool {
    return startTime > endTime
  }
}

public extension TimeRange {
  func contains(_ timeOfDay: TimeOfDay) -> Bool {
    if rangeFallsOverMidnight {
      return timeOfDay >= startTime || timeOfDay < endTime
    } else {
      return timeOfDay >= startTime && timeOfDay < endTime
    }
  }
}

public func ..< (lhs: TimeOfDay, rhs: TimeOfDay) -> TimeRange {
  return TimeRange(startTime: lhs, endTime: rhs)
}
