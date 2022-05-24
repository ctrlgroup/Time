//
//  CalendarDateStringTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class CalendarDateStringTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Conversion of a Calendar Date to and from a String") {

      it("should create a string representation of a date") {
        let sut = try! CalendarDate(day: 25, month: 12, year: 2019)
        expect(sut.connectDateFormatStringRepresentation).to(equal("25/12/2019"))
      }

      it("should create a ISO8601 string representation of a date") {
        let sut = try! CalendarDate(day: 25, month: 12, year: 2019)
        expect(sut.iso8601StringRepresentation).to(equal("2019-12-25"))
      }

      it("should create a full formatted ISO8601 string representation of a date with midnight") {
        let sut = try! CalendarDate(day: 25, month: 12, year: 2019)
        let timeZone = TimeZone(secondsFromGMT: 2 * 60 * 60)!
        let result = sut.fullISO8601StringRepresentation(in: timeZone)
        expect(result).to(equal("2019-12-25T00:00:00+02:00"))
      }

      it("should add leading zeros to the components") {
        let sut = try! CalendarDate(day: 1, month: 1, year: 1)
        expect(sut.connectDateFormatStringRepresentation).to(equal("01/01/0001"))
      }

      it("should throw if string contains invalid characters") {
        let string = "01/two/2003"
        expect(try CalendarDate(string: string))
          .to(throwError(errorType: CalendarDateStringError.self))
      }

      it("should throw if is less than 7 characters") {
        let string = "01/02/"
        expect(try CalendarDate(string: string))
          .to(throwError(errorType: CalendarDateStringError.self))
      }

      it("should throw if it does not contain exactly 2 / symbols") {
        let string = "01/022019"
        expect(try CalendarDate(string: string))
          .to(throwError(errorType: CalendarDateStringError.self))
      }

      it("should throw if it does not contain exactly 3 integers") {
        let string1 = "12//345"
        expect(try CalendarDate(string: string1))
          .to(throwError(errorType: CalendarDateStringError.self))

        let string2 = "12/345/"
        expect(try CalendarDate(string: string2))
          .to(throwError(errorType: CalendarDateStringError.self))
      }

      it("should be initializable from a string") {
        let dateString = "25/12/2019"
        let expectedResult = try! CalendarDate(day: 25, month: 12, year: 2019)
        expect(try? CalendarDate(string: dateString)).to(equal(expectedResult))
      }

      it("should be initializable from an ISO8601 formatted string") {
        let iso8601DateString = "2019-12-25"
        let expectedResult = try! CalendarDate(day: 25, month: 12, year: 2019)
        expect(try? CalendarDate(iso8601String: iso8601DateString)).to(equal(expectedResult))
      }

      it("should be initializable from a string when components have leading zeros") {
        let dateString = "02/03/0019"
        let expectedResult = try! CalendarDate(day: 2, month: 3, year: 19)
        expect(try? CalendarDate(string: dateString)).to(equal(expectedResult))
      }
    }
  }
}
