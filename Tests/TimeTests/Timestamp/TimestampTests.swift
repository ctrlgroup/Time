//
//  TimestampTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class TimestampTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Timestamp") {

      let date = Date(timeIntervalSince1970: 123456789)
      let timezone = TimeZone(abbreviation: "EEST")!
      let sut = Timestamp(date: date, timeZone: timezone)

      it("should contain a date and time zone") {
        expect(sut.date).to(equal(date))
        expect(sut.timeZone).to(equal(timezone))
      }

      it("can create a calendar date") {
        let expected = try! CalendarDate(day: 29, month: 11, year: 1973)
        expect(sut.day).to(equal(expected))
      }

      it("can create a time of day") {
        expect(sut.timeOfDay).to(equal(23⁝33⁝09))
      }
    }
  }
}
