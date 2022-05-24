//
//  Timestamp+ArithmeticTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimestampArithmeticTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Timestamp+Arithmetic") {

      it("can add time intervals") {
        let date = Date(timeIntervalSince1970: 1000)
        let timeInterval: TimeInterval = 2000
        let sut = Timestamp(date: date, timeZone: .utc)
        let result = sut + timeInterval
        expect(result.date.timeIntervalSince1970).to(equal(3000))
        expect(result.timeZone).to(equal(.utc))
      }

      it("can find the difference between two timestamps") {
        let timestamp1 = Timestamp(date: Date(timeIntervalSince1970: 1000), timeZone: .utc)
        let timestamp2 = Timestamp(date: Date(timeIntervalSince1970: 3000), timeZone: .utc)
        let result = timestamp2 - timestamp1
        expect(result).to(equal(2000))
      }
    }
  }
}
