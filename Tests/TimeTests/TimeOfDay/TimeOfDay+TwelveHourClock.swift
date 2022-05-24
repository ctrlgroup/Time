//
//  TimeOfDay+TwelveHourClock.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimeOfDayTwelveHourClockTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Time Of Day hour") {

      let locale = Locale(identifier: "en")

      it("can be converted to a 12 hour clock format") {
        let example1 = try! TimeOfDay(hour: 00, minute: 30, second: 00)
        expect(example1.hourInTwelveHourClock).to(equal(12))
        expect(example1.period(locale: locale)).to(equal("AM"))

        let example2 = try! TimeOfDay(hour: 05, minute: 00, second: 00)
        expect(example2.hourInTwelveHourClock).to(equal(5))
        expect(example2.period(locale: locale)).to(equal("AM"))

        let example3 = try! TimeOfDay(hour: 12, minute: 30, second: 00)
        expect(example3.hourInTwelveHourClock).to(equal(12))
        expect(example3.period(locale: locale)).to(equal("PM"))

        let example4 = try! TimeOfDay(hour: 14, minute: 00, second: 00)
        expect(example4.hourInTwelveHourClock).to(equal(2))
        expect(example4.period(locale: locale)).to(equal("PM"))

        let example5 = try! TimeOfDay(hour: 23, minute: 59, second: 00)
        expect(example5.hourInTwelveHourClock).to(equal(11))
        expect(example5.period(locale: locale)).to(equal("PM"))
      }
    }
  }
}
