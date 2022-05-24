//
//  TimeOfDayISO8601StringTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimeOfDayISO8601StringTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("TimeOfDayISO8601String") {

      let sut = 12⁝34⁝56

      it("can be instantiated from an ISO8601 string") {
        expect(try? TimeOfDay(iso8601String: "12:34:56")).to(equal(12⁝34⁝56))
        expect(try? TimeOfDay(iso8601String: "12:34")).to(equal(12⁝34))
      }

      it("throws an error for invalid ISO8601 strings") {
        let error = TimeOfDayError.invalidISO8601String
        expect(try TimeOfDay(iso8601String: "foobar")).to(throwError(error))
        expect(error.errorDescription).to(equal("Time is not a valid ISO 8601 string."))
      }

      it("can be converted to an ISO8601 string") {
        let timeZone = TimeZone(identifier: "Europe/Tallinn")!
        let timestamp = Timestamp(day: .example, time: sut, timeZone: timeZone)
        expect(sut.iso8601StringRepresentationWithTimeZone(using: timestamp, includeSeconds: true))
          .to(equal("12:34:56+02:00"))
      }

      it("can be converted to an ISO8601 string with negative time zone") {
        let timeZone = TimeZone(identifier: "America/New_York")!
        let timestamp = Timestamp(day: .example, time: sut, timeZone: timeZone)
        expect(sut.iso8601StringRepresentationWithTimeZone(using: timestamp, includeSeconds: true))
          .to(equal("12:34:56-05:00"))
      }

      it("can be converted to an ISO8601 string with UTC time zone") {
        let timestamp = Timestamp(day: .example, time: sut, timeZone: .utc)
        expect(sut.iso8601StringRepresentationWithTimeZone(using: timestamp, includeSeconds: true))
          .to(equal("12:34:56Z"))
      }

      it("can be converted to an ISO8601 string out seconds") {
        let timestamp = Timestamp(day: .example, time: sut, timeZone: .utc)
        expect(sut.iso8601StringRepresentationWithTimeZone(using: timestamp, includeSeconds: false))
          .to(equal("12:34Z"))
      }
    }
  }
}
