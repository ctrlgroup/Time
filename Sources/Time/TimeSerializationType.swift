//
//  TimeSerializationType.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public enum TimeSerializationType {
  case object
  case iso8601String
}

public extension CodingUserInfoKey {
  static let timeSerializationType =
    CodingUserInfoKey(rawValue: "com.ctrl-group.Time.timeSerializationType")!
}
