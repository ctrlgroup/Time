//
//  CalendarDateStringFormattingTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class CalendarDateStringFormattingTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Converting Calendar Dates to a string using date formatting") {

      let sut = try! CalendarDate(day: 23, month: 11, year: 1937)

      it("should be able to create a formatted string") {
        let result = sut.string(withStyle: .medium, locale: .english)
        expect(result).to(equal("Nov 23, 1937"))
      }

      it("should cache date formatters with a given style") {
        let date = Date()
        for _ in 0 ..< 1_000 {
          _ = sut.string(withStyle: .medium, locale: .english)
        }
        expect(-date.timeIntervalSinceNow).to(beLessThanOrEqualTo(0.1))
      }

      it("can create a string with a given format") {
        let result = sut.string(withFormat: "d MMMM y", locale: .english)
        expect(result).to(equal("November 23, 1937"))
      }
    }
  }
}

final class DateFormatterCalendarDateTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Converting Calendar Dates to a string using date formatting") {

      let date = try! CalendarDate(day: 23, month: 11, year: 1937)

      var sut: DateFormatter!

      beforeEach {
        sut = DateFormatter()
        sut.dateStyle = .medium
        sut.timeStyle = .none
        sut.locale = Locale(identifier: "en")
      }

      it("can create a string from a calendar date") {
        let result = sut.string(from: date)
        expect(result).to(equal("Nov 23, 1937"))
      }

      it("works independant of time zone") {
        sut.timeZone = TimeZone(abbreviation: "PDT")
        let result = sut.string(from: date)
        expect(result).to(equal("Nov 23, 1937"))
      }
    }
  }
}
