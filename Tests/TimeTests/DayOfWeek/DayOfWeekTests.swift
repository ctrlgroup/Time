//
//  DayOfWeekTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class DayOfWeekTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Day of week") {

      it("can be created from a DateComponents") {
        expect(DateComponents(weekday: 1).dayOfWeek).to(equal(.sunday))
        expect(DateComponents(weekday: 2).dayOfWeek).to(equal(.monday))
        expect(DateComponents(weekday: 3).dayOfWeek).to(equal(.tuesday))
        expect(DateComponents(weekday: 4).dayOfWeek).to(equal(.wednesday))
        expect(DateComponents(weekday: 5).dayOfWeek).to(equal(.thursday))
        expect(DateComponents(weekday: 6).dayOfWeek).to(equal(.friday))
        expect(DateComponents(weekday: 7).dayOfWeek).to(equal(.saturday))
      }

      it("has a very short weekday symbol") {
        expect(DayOfWeek.monday.veryShortWeekdaySymbol(locale: .english)).to(equal("M"))
        expect(DayOfWeek.tuesday.veryShortWeekdaySymbol(locale: .english)).to(equal("T"))
        expect(DayOfWeek.wednesday.veryShortWeekdaySymbol(locale: .english)).to(equal("W"))
        expect(DayOfWeek.thursday.veryShortWeekdaySymbol(locale: .english)).to(equal("T"))
        expect(DayOfWeek.friday.veryShortWeekdaySymbol(locale: .english)).to(equal("F"))
        expect(DayOfWeek.saturday.veryShortWeekdaySymbol(locale: .english)).to(equal("S"))
        expect(DayOfWeek.sunday.veryShortWeekdaySymbol(locale: .english)).to(equal("S"))
      }

      it("has a short standalone weekday symbol") {
        expect(DayOfWeek.monday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Mon"))
        expect(DayOfWeek.tuesday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Tue"))
        expect(DayOfWeek.wednesday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Wed"))
        expect(DayOfWeek.thursday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Thu"))
        expect(DayOfWeek.friday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Fri"))
        expect(DayOfWeek.saturday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Sat"))
        expect(DayOfWeek.sunday.shortStandaloneWeekdaySymbol(locale: .english)).to(equal("Sun"))
      }

      it("can calculate the DateComponents compatible weekday index") {
        expect(DayOfWeek.sunday.dateComponentsCompatibleWeekday).to(equal(1))
        expect(DayOfWeek.monday.dateComponentsCompatibleWeekday).to(equal(2))
        expect(DayOfWeek.tuesday.dateComponentsCompatibleWeekday).to(equal(3))
        expect(DayOfWeek.wednesday.dateComponentsCompatibleWeekday).to(equal(4))
        expect(DayOfWeek.thursday.dateComponentsCompatibleWeekday).to(equal(5))
        expect(DayOfWeek.friday.dateComponentsCompatibleWeekday).to(equal(6))
        expect(DayOfWeek.saturday.dateComponentsCompatibleWeekday).to(equal(7))
      }
    }
  }
}
