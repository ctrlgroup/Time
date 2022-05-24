//
//  ClockTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble
import TimeTestHelpers

final class ClockTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Clock") {

      // 22 January 2019 20:05:17
      let exampleDate = Date(timeIntervalSince1970: 1548187517)
      let timeZone = TimeZone.utc

      var dateFactoryStub: DateFactoryStub!

      var sut: Clock!

      beforeEach {
        dateFactoryStub = DateFactoryStub(exampleDate)
        sut = Clock(timeZone: timeZone, dateFactory: dateFactoryStub)
      }

      it("will return the timestamp provided by date factory") {
        let expected = Timestamp(date: exampleDate, timeZone: timeZone)
        expect(sut.readTimestamp()).to(equal(expected))
      }

      it("can return a correct DateTime object for the current date and time") {
        let result = sut.readDateTime()
        expect(result.calendarDate.day).to(equal(22))
        expect(result.calendarDate.month).to(equal(1))
        expect(result.calendarDate.year).to(equal(2019))
        expect(result.calendarDate.dayOfWeek).to(equal(.tuesday))
        expect(result.timeOfDay.hour).to(equal(20))
        expect(result.timeOfDay.minute).to(equal(05))
        expect(result.timeOfDay.second).to(equal(17))
      }

      context("in timezone +1") {
        beforeEach {
          let timeZone = TimeZone(secondsFromGMT: Int(TimeInterval.hour))!
          sut = Clock(timeZone: timeZone, dateFactory: dateFactoryStub)
        }

        it("takes timezone into account when creating a date") {
          let expected = try! TimeOfDay(hour: 21, minute: 05, second: 17)
          let result = sut.readDateTime().timeOfDay
          expect(result).to(equal(expected))
        }
      }
    }
  }
}
