//
//  TimestampRelativeTimeFormattingTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimestampRelativeTimeFormattingTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Timestamp+RelativeTimeFormatting") {

      let locale = Locale(identifier: "en-GB")

      func timestamp(forDay calendarDate: CalendarDate, time: TimeOfDay = 00⁝00) -> Timestamp {
        let dateTime = DateTime(calendarDate: calendarDate, timeOfDay: time)
        return Timestamp(date: dateTime.date(in: .current), timeZone: .current)
      }

      let earlierToday = timestamp(forDay: CalendarDate(date: Date(), timeZone: .utc), time: 00⁝01)
      let yesterday = timestamp(forDay: CalendarDate(date: Date(), timeZone: .utc) - 1, time: 12⁝34)

      it("uses today") {
        let result = earlierToday.localisedStringRelativeToToday(locale: locale)
        expect(result.lowercased()).to(equal("today"))
      }

      it("uses yesterday") {
        let result = yesterday.localisedStringRelativeToToday(locale: locale)
        expect(result.lowercased()).to(equal("yesterday"))
      }

      it("translates string") {
        let locale = Locale(identifier: "et_EE")
        let result = earlierToday.localisedStringRelativeToToday(locale: locale)
        expect(result.lowercased()).to(equal("täna"))
      }

      it("uses a date for any other date") {
        let sut = timestamp(forDay: try! CalendarDate(day: 2, month: 5, year: 2006), time: 23⁝59)
        let result = sut.localisedStringRelativeToToday(locale: locale)
        expect(result).to(equal("2 May 2006"))
      }
    }
  }
}
