//
//  TimeZoneFactoryStub.swift
//  TimeTestHelpers
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import Time

public class TimeZoneProviderStub: TimeZoneProvider {
  public var testTimeZone: TimeZone
  public init(_ timeZone: TimeZone) { testTimeZone = timeZone }
  public func currentTimeZone() -> TimeZone { return testTimeZone }
}
