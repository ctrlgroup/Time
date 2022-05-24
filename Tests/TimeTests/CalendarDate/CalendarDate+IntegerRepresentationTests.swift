//
//  CalendarDate+IntegerRepresentationTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class CalendarDateIntegerRepresentationTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("CalendarDate+IntegerRepresentation") {
      it("represents 01/01/2001 as 0") {
        let sut = try! CalendarDate(day: 1, month: 1, year: 2001)
        expect(sut.intRepresentation).to(equal(0))
      }

      it("represents 02/01/2001 as 1") {
        let sut = try! CalendarDate(day: 2, month: 1, year: 2001)
        expect(sut.intRepresentation).to(equal(1))
      }

      it("represents 31/12/2000 as -1") {
        let sut = try! CalendarDate(day: 31, month: 12, year: 2000)
        expect(sut.intRepresentation).to(equal(-1))
      }

      it("represents 03/01/2020 as 6941") {
        let sut = try! CalendarDate(day: 03, month: 01, year: 2020)
        expect(sut.intRepresentation).to(equal(6941))
      }
    }
  }
}
