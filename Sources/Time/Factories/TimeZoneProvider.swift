//
//  TimeZoneFactory.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol TimeZoneProvider {
  func currentTimeZone() -> TimeZone
}

public class SystemTimeZoneProvider: TimeZoneProvider {
  public init() {}
  public func currentTimeZone() -> TimeZone {
    return TimeZone.current
  }
}
