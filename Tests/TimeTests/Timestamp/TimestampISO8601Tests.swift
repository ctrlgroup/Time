//
//  TimestampISO8601Tests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class TimestampISO8601Tests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Timestamp ISO8601") {
      it("can be represented as an ISO8601 string") {
        let date = Date(timeIntervalSince1970: 1575998130)
        let sut = Timestamp(date: date, timeZone: .utc)
        expect(sut.iso8601StringRepresentation).to(equal("2019-12-10T17:15:30Z"))
      }

      it("can be represented as an ISO8601 string with time zone") {
        let date = Date(timeIntervalSince1970: 1575998130)
        let sut = Timestamp(date: date, timeZone: TimeZone(identifier: "Europe/Tallinn")!)
        expect(sut.iso8601StringRepresentation).to(equal("2019-12-10T19:15:30+02:00"))
      }

      it("can be created from an ISO8601 string") {
        let sut = try Timestamp(iso8601String: "2019-12-10T17:15:30Z", timeZone: .utc)
        expect(sut.date).to(beCloseTo(Date(timeIntervalSince1970: 1575998130), within: 0.1))
        expect(sut.timeZone).to(equal(.utc))
      }

      it("can be created from an ISO8601 string with time zone") {
        let timeZone = TimeZone(identifier: "Europe/Tallinn")!
        let sut = try Timestamp(iso8601String: "2019-12-10T19:15:30+02:00", timeZone: timeZone)
        expect(sut.date).to(beCloseTo(Date(timeIntervalSince1970: 1575998130), within: 0.1))
        expect(sut.timeZone).to(equal(timeZone))
      }
    }
  }
}
