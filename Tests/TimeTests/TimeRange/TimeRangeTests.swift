//
//  TimeRangeTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimeRangeTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Time Range") {

      let startTime = try! TimeOfDay(hour: 17, minute: 34, second: 58)
      let endTime = try! TimeOfDay(hour: 23, minute: 55, second: 23)
      let sut = TimeRange(startTime: startTime, endTime: endTime)

      it("should have a start and an end time") {
        expect(sut.startTime).to(equal(startTime))
        expect(sut.endTime).to(equal(endTime))
      }

      it("can determine if a TimeOfDay is contained within the Range") {
        let timeWithinRange = try! TimeOfDay(hour: 18, minute: 35, second: 23)
        let result = sut.contains(timeWithinRange)
        expect(result).to(beTrue())
      }

      it("can determine if a TimeOfDay is not contained within the range") {
        let timeOutsideOfRange = try! TimeOfDay(hour: 23, minute: 55, second: 24)
        let result = sut.contains(timeOutsideOfRange)
        expect(result).to(beFalse())
      }

      it("should contain the startTime in the range") {
        let result = sut.contains(startTime)
        expect(result).to(beTrue())
      }

      it("should not contain the endTime in the range") {
        let result = sut.contains(endTime)
        expect(result).to(beFalse())
      }

      it("should contain the second before the endTime in the range") {
        let oneSecondBeforeEndTime = try! TimeOfDay(hour: 23, minute: 55, second: 22)
        let result = sut.contains(oneSecondBeforeEndTime)
        expect(result).to(beTrue())
      }

      it("can be initialised with the ... operator") {
        let sut = startTime..<endTime
        expect(sut).to(beAKindOf(TimeRange.self))
        expect(sut.startTime).to(equal(startTime))
        expect(sut.endTime).to(equal(endTime))
      }

      it("will be able to calculate whether a time is in a range that falls over midnight it ") {
        let timeAfterMidnight = try! TimeOfDay(hour: 01, minute: 02, second: 03)
        let sut = TimeRange(startTime: endTime, endTime: startTime)
        let result = sut.contains(timeAfterMidnight)
        expect(result).to(beTrue())
      }

      it("will be able to calculate whether a time outside of a range that falls over midnight ") {
        let timeAfterMidnight = try! TimeOfDay(hour: 18, minute: 35, second: 23)
        let sut = TimeRange(startTime: endTime, endTime: startTime)
        let result = sut.contains(timeAfterMidnight)
        expect(result).to(beFalse())
      }

      it("will be able to calculate whether a time is within a range that ends at midnight") {
        let timeWithinRange = try! TimeOfDay(hour: 23, minute: 59, second: 59)
        let midnight = try! TimeOfDay(hour: 0, minute: 0, second: 0)
        let elevenAtNight = try! TimeOfDay(hour: 23, minute: 0, second: 0)
        let sut = TimeRange(startTime: elevenAtNight, endTime: midnight)
        let result = sut.contains(timeWithinRange)
        expect(result).to(beTrue())
      }

      it("will be able to calculate whether a time is outside of a range that ends at midnight") {
        let timeOutsideRange = try! TimeOfDay(hour: 0, minute: 0, second: 1)
        let midnight = try! TimeOfDay(hour: 0, minute: 0, second: 0)
        let elevenAtNight = try! TimeOfDay(hour: 23, minute: 0, second: 0)
        let sut = TimeRange(startTime: elevenAtNight, endTime: midnight)
        let result = sut.contains(timeOutsideRange)
        expect(result).to(beFalse())
      }

      it("s last included time is a second before the end time") {
        let sut = 12⁝00 ..< 13⁝00
        expect(sut.lastIncludedTime).to(equal(12⁝59⁝59))
      }

      it("s last included time can be nil") {
        let sut = 12⁝00 ..< 12⁝00
        expect(sut.lastIncludedTime).to(beNil())
      }
    }
  }
}
