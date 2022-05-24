//
//  CalendarDate+ArithmeticTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class CalendarDateArithmeticTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("CalendarDate+Arithmetic") {

      let example = try! CalendarDate(day: 1, month: 2, year: 2003)

      it("can add seconds to a date") {
        let secondsInADay = 24 * 60 * 60
        let result = example.dateByAdding(secondsInADay * 3, unit: .second)
        expect(result).to(equal(try! CalendarDate(day: 4, month: 2, year: 2003)))
      }

      it("adding seconds less than a day produces the same date") {
        let secondsInADay = 24 * 60 * 60
        let result = example.dateByAdding(secondsInADay - 1, unit: .second)
        expect(result).to(equal(example))
      }

      it("can add months to a date") {
        let result = example.dateByAdding(14, unit: .month)
        expect(result).to(equal(try! CalendarDate(day: 1, month: 4, year: 2004)))
      }

      it("can loop through other units") {
        let result = example.dateByAdding(6, unit: .month)
        expect(result).to(equal(try! CalendarDate(day: 1, month: 8, year: 2003)))
      }
    }
  }
}
