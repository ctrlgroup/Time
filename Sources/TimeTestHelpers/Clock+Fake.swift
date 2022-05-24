//
//  Clock+Fake.swift
//  TimeTestHelpers
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import Time
import Resolver

public extension Clock {
  static var standardClock: Clock = Resolver.resolve()

  convenience init(timestamp: Timestamp) {
    let timeZoneProvider = TimeZoneProviderStub(timestamp.timeZone)
    let dateFactory = DateFactoryStub(timestamp.date)
    self.init(timeZoneProvider: timeZoneProvider,
              dateFactory: dateFactory)
  }

  convenience init(timeZone: TimeZone = .utc, dateFactory: DateFactory = SystemDateFactory()) {
    let timeZoneProvider = TimeZoneProviderStub(timeZone)
    self.init(timeZoneProvider: timeZoneProvider,
              dateFactory: dateFactory)
  }

  var timestamp: Timestamp {
    get { readTimestamp() }
    set {
      guard let timeZoneProvider = timeZoneProvider as? TimeZoneProviderStub,
            let dateFactory = dateFactory as? DateFactoryStub else {
        return
      }
      timeZoneProvider.testTimeZone = newValue.timeZone
      dateFactory.testDate = newValue.date
    }
  }
}
