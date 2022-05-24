//
//  TimeOfDayStringTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimeOfDayStringTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("TimeOfDay to string conversion") {
      it("can be represented as a string in british english") {
        let timeOfDay = 15⁝34⁝56
        let locale = Locale(identifier: "en-GB")

        expect(timeOfDay.string(style: (.short, .localeDefault), locale: locale))
          .to(equal("15:34"))

        expect(timeOfDay.string(style: (.short, .twelveHour), locale: locale))
          .to(equal("3:34 pm"))

        expect(timeOfDay.string(style: (.short, .twentyFourHour), locale: locale))
          .to(equal("15:34"))

        expect(timeOfDay.string(style: (.medium, .localeDefault), locale: locale))
          .to(equal("15:34:56"))

        expect(timeOfDay.string(style: (.medium, .twelveHour), locale: locale))
          .to(equal("3:34:56 pm"))

        expect(timeOfDay.string(style: (.medium, .twentyFourHour), locale: locale))
          .to(equal("15:34:56"))

        expect(TimeOfDay(string: "foobar", style: (.medium, .twentyFourHour), locale: locale))
          .to(beNil())
      }

      it("can be represented as a string in american english") {
        let timeOfDay = 15⁝34⁝56
        let locale = Locale(identifier: "en-US")

        expect(timeOfDay.string(style: (.short, .localeDefault), locale: locale))
          .to(equal("3:34 PM"))

        expect(timeOfDay.string(style: (.short, .twelveHour), locale: locale))
          .to(equal("3:34 PM"))

        expect(timeOfDay.string(style: (.short, .twentyFourHour), locale: locale))
          .to(equal("15:34"))

        expect(timeOfDay.string(style: (.medium, .localeDefault), locale: locale))
          .to(equal("3:34:56 PM"))

        expect(timeOfDay.string(style: (.medium, .twelveHour), locale: locale))
          .to(equal("3:34:56 PM"))

        expect(timeOfDay.string(style: (.medium, .twentyFourHour), locale: locale))
          .to(equal("15:34:56"))
      }

      it("can be created from a british english string") {
        let locale = Locale(identifier: "en-GB")

        expect(TimeOfDay(string: "15:34", style: (.short, .localeDefault), locale: locale))
          .to(equal(15⁝34))

        expect(TimeOfDay(string: "3:34 pm", style: (.short, .twelveHour), locale: locale))
          .to(equal(15⁝34))

        expect(TimeOfDay(string: "15:34", style: (.short, .twentyFourHour), locale: locale))
          .to(equal(15⁝34))

        expect(TimeOfDay(string: "15:34:56", style: (.medium, .localeDefault), locale: locale))
          .to(equal(15⁝34⁝56))

        expect(TimeOfDay(string: "3:34:56 pm", style: (.medium, .twelveHour), locale: locale))
          .to(equal(15⁝34⁝56))

        expect(TimeOfDay(string: "15:34:56", style: (.medium, .twentyFourHour), locale: locale))
          .to(equal(15⁝34⁝56))
      }

      it("can be created from a american english string") {
        let locale = Locale(identifier: "en-US")

        expect(TimeOfDay(string: "3:34 PM", style: (.short, .localeDefault), locale: locale))
          .to(equal(15⁝34))

        expect(TimeOfDay(string: "3:34 PM", style: (.short, .twelveHour), locale: locale))
          .to(equal(15⁝34))

        expect(TimeOfDay(string: "15:34", style: (.short, .twentyFourHour), locale: locale))
          .to(equal(15⁝34))

        expect(TimeOfDay(string: "3:34:56 PM", style: (.medium, .localeDefault), locale: locale))
          .to(equal(15⁝34⁝56))

        expect(TimeOfDay(string: "3:34:56 PM", style: (.medium, .twelveHour), locale: locale))
          .to(equal(15⁝34⁝56))

        expect(TimeOfDay(string: "15:34:56", style: (.medium, .twentyFourHour), locale: locale))
          .to(equal(15⁝34⁝56))
      }

      it("has a default string style") {
        expect(TimeOfDay.StringStyle.default.size.timeStyle).to(equal(.short))
        expect(TimeOfDay.StringStyle.default.hourStyle).to(equal(.localeDefault))
      }
    }
  }
}

final class DateFormatterTimeOfDayTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Converting Calendar Dates to a string using date formatting") {

      let timeOfDay = 15⁝34⁝56

      var sut: DateFormatter!

      beforeEach {
        sut = DateFormatter()
        sut.dateStyle = .none
        sut.timeStyle = .medium
        sut.locale = Locale(identifier: "en")
      }

      it("can create a string from a calendar date") {
        let result = sut.string(from: timeOfDay)
        expect(result).to(equal("3:34:56 PM"))
      }

      it("works independant of time zone") {
        sut.timeZone = TimeZone(abbreviation: "PDT")
        let result = sut.string(from: timeOfDay)
        expect(result).to(equal("3:34:56 PM"))
      }

      it("can create a TimeOfDay from a string") {
        let result = sut.timeOfDay(from: "3:34:56 PM")
        expect(result).to(equal(15⁝34⁝56))
      }

      it("can create a TimeOfDay from a string independant of time zone") {
        sut.timeZone = TimeZone(abbreviation: "PDT")
        let result = sut.timeOfDay(from: "3:34:56 PM")
        expect(result).to(equal(15⁝34⁝56))
      }
    }
  }
}
