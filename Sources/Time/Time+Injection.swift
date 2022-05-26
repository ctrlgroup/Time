//
//  Time+Injection.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Resolver

public extension Resolver {
  static func registerTimeServices() {
    register { SystemTimeZoneProvider() as TimeZoneProvider }
    register { SystemDateFactory() as DateFactory }
    register { Clock(timeZoneProvider: resolve(), dateFactory: resolve()) }
  }
}
