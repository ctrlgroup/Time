//
//  TimeInterval.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

public extension TimeInterval {
  static let minute: TimeInterval = 60
  static let hour: TimeInterval = .minute * 60
  static let day: TimeInterval = .hour * 24
}

public extension Int {
  var seconds: TimeInterval { return TimeInterval(self) }
  var minutes: TimeInterval { return TimeInterval(self) * TimeInterval.minute }
  var hours  : TimeInterval { return TimeInterval(self) * TimeInterval.hour   }
  var days   : TimeInterval { return TimeInterval(self) * TimeInterval.day    }
}
