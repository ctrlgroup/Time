//
//  TimeOfDayTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimeOfDayTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Time Of Day") {

      let sut = try! TimeOfDay(hour: 23, minute: 59, second: 59)

      it("contains a hour, minute and second") {
        expect(sut.hour).to(equal(23))
        expect(sut.minute).to(equal(59))
        expect(sut.second).to(equal(59))
      }

      it("cannot be instantiated with a time with too many hours") {
        let error = TimeOfDayError.malformedTime(hour: 24, minute: 59, second: 59)
        expect(try TimeOfDay(hour: 24, minute: 59, second: 59)).to(throwError(error))
        expect(error.errorDescription).to(contain("24", "59", "59"))
      }

      it("cannot be instantiated with a time with too many minutes") {
        let error = TimeOfDayError.malformedTime(hour: 23, minute: 60, second: 59)
        expect(try TimeOfDay(hour: 23, minute: 60, second: 59)).to(throwError(error))
        expect(error.errorDescription).to(contain("23", "60", "59"))
      }

      it("cannot be instantiated with a time with too many seconds") {
        let error = TimeOfDayError.malformedTime(hour: 23, minute: 59, second: 60)
        expect(try TimeOfDay(hour: 23, minute: 59, second: 60)).to(throwError(error))
        expect(error.errorDescription).to(contain("23", "59", "60"))
      }

      it("is equal to a TimeOfDay representing the same time") {
        let other = try! TimeOfDay(hour: 23, minute: 59, second: 59)
        expect(sut).to(equal(other))
      }

      it("is not equal to a TimeOfDay representing a different time") {
        let other = try! TimeOfDay(hour: 11, minute: 01, second: 01)
        expect(sut).notTo(equal(other))
      }

      it("can be instantiated with a timestamp and a timezone") {
        // 22 January 2019 20:05:17
        let timestamp = Date(timeIntervalSince1970: 1548187517)
        let timezone = TimeZone(secondsFromGMT: 0)!
        let result = TimeOfDay(date: timestamp, timeZone: timezone)
        expect(result.hour).to(equal(20))
        expect(result.minute).to(equal(05))
        expect(result.second).to(equal(17))
      }

      it("can calculate whether one time is preceeds another") {
        let firstTime = try! TimeOfDay(hour: 13, minute: 30, second: 02)
        let secondTime = try! TimeOfDay(hour: 13, minute: 30, second: 03)
        expect(firstTime < secondTime).to(beTrue())
      }

      it("can be initialised with just hours and minutes using the ⁝ operator") {
        let sut = 17⁝23
        expect(sut).to(beAKindOf(TimeOfDay.self))
        expect(sut.hour).to(equal(17))
        expect(sut.minute).to(equal(23))
        expect(sut.second).to(equal(0))
      }

      it("can be initialised with hours, minutes and seconds using the ⁝ operator") {
        let sut = 17⁝23⁝57
        expect(sut).to(beAKindOf(TimeOfDay.self))
        expect(sut.hour).to(equal(17))
        expect(sut.minute).to(equal(23))
        expect(sut.second).to(equal(57))
      }

      it("can be initialised with seconds since midnight") {
        let seconds: TimeInterval = 12.hours + 34.minutes + 56.seconds
        let sut = try? TimeOfDay(secondsSinceMidnight: Int(seconds))
        expect(sut?.hour).to(equal(12))
        expect(sut?.minute).to(equal(34))
        expect(sut?.second).to(equal(56))
      }

      it("can add seconds") {
        let sut = 17⁝23⁝57
        let result = sut + 30
        expect(result).to(equal(17⁝24⁝27))
      }

      it("can add seconds over midnight") {
        let sut = 23⁝59⁝59
        let result = sut + 1
        expect(result).to(equal(00⁝00⁝00))
      }

      it("can subtract seconds") {
        let sut = 17⁝23⁝57
        let result = sut - 30
        expect(result).to(equal(17⁝23⁝27))
      }

      it("can subtract seconds over midnight") {
        let sut = 00⁝00⁝15
        let result = sut - 30
        expect(result).to(equal(23⁝59⁝45))
      }

      it("can compute the difference between two times") {
        let result = 06⁝00 - 05⁝55
        expect(result).to(equal(300.seconds))
      }

      it("can produce a label for morning/afternoon/evening") {
        expect((00⁝00⁝00).label).to(equal(TimeOfDay.TimeOfDayLabel.morning.rawValue))
        expect((11⁝59⁝59).label).to(equal(TimeOfDay.TimeOfDayLabel.morning.rawValue))
        expect((12⁝00⁝00).label).to(equal(TimeOfDay.TimeOfDayLabel.afternoon.rawValue))
        expect((16⁝00⁝00).label).to(equal(TimeOfDay.TimeOfDayLabel.afternoon.rawValue))
        expect((17⁝59⁝59).label).to(equal(TimeOfDay.TimeOfDayLabel.afternoon.rawValue))
        expect((18⁝00⁝00).label).to(equal(TimeOfDay.TimeOfDayLabel.evening.rawValue))
        expect((23⁝59⁝59).label).to(equal(TimeOfDay.TimeOfDayLabel.evening.rawValue))
      }
    }
  }
}

final class TimeOfDayErrorTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Time Of Day Error") {

      it("will return false when comparing two different errors for equality") {
        let error1 = TimeOfDayError.malformedTime(hour: 1, minute: 2, second: 3)
        let error2 = TimeOfDayError.malformedTime(hour: 4, minute: 5, second: 6)
        expect(error1).toNot(equal(error2))
      }

      it("will return true when comparing two of the same error for equality") {
        let error1 = TimeOfDayError.malformedTime(hour: 1, minute: 2, second: 3)
        let error2 = TimeOfDayError.malformedTime(hour: 1, minute: 2, second: 3)
        expect(error1).to(equal(error2))
      }

    }
  }
}
