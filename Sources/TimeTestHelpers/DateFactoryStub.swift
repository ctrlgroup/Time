//
//  DateFactoryStub.swift
//  TimeTestHelpers
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import Time

public class DateFactoryStub: DateFactory {
  public var testDate: Date
  public init(_ date: Date) { testDate = date }
  public func currentDate() -> Date { return testDate }
}
