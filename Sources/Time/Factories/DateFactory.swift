//
//  DateFactory.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol DateFactory {
  func currentDate() -> Date
}

public class SystemDateFactory: DateFactory {
  public init() { }

  public func currentDate() -> Date {
    return Date()
  }
}
