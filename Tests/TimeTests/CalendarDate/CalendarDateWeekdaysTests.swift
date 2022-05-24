//
//  CalendarDateWeekdaysTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class CalendarDateWeekdaysTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("CalendarDateWeekdays") {

      let monday = try! CalendarDate(day: 1, month: 2, year: 2021)
      let wednesday = try! CalendarDate(day: 3, month: 2, year: 2021)
      let sunday = try! CalendarDate(day: 7, month: 2, year: 2021)
      let nextMonday = try! CalendarDate(day: 8, month: 2, year: 2021)

      it("can return the previous Monday from Wednesday") {
        expect(wednesday.previous(weekday: .monday)).to(equal(monday))
      }

      it("can return the previous Wednesday from Monday") {
        expect(nextMonday.previous(weekday: .wednesday)).to(equal(wednesday))
      }

      it("can return the previous Monday from Monday") {
        expect(nextMonday.previous(weekday: .monday)).to(equal(monday))
      }

      it("can return the previous Monday from Sunday") {
        expect(sunday.previous(weekday: .monday)).to(equal(monday))
      }

      it("can return the previous Sunday from Monday") {
        expect(nextMonday.previous(weekday: .sunday)).to(equal(sunday))
      }

      it("can return the next Monday from Sunday") {
        expect(sunday.next(weekday: .monday)).to(equal(nextMonday))
      }

      it("can return the weekday in the current week") {
        expect(wednesday.weekdayInCurrentWeek(.monday)).to(equal(monday))
        expect(nextMonday.weekdayInCurrentWeek(.monday)).to(equal(nextMonday))
        expect(monday.weekdayInCurrentWeek(.sunday)).to(equal(sunday))
        expect(monday.weekdayInCurrentWeek(.wednesday)).to(equal(wednesday))
      }
    }
  }
}
