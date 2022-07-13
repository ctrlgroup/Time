//
//  CalendarDateRangeTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class CalendarDateRangeTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Calendar Date Range") {

      let startDate = try! CalendarDate(day: 5, month: 6, year: 2007)
      let endDate = try! CalendarDate(day: 10, month: 6, year: 2007)
      let sut = CalendarDateRange(startDate: startDate, endDate: endDate)

      it("should have a start date and an end date") {
        expect(sut.startDate).to(equal(startDate))
        expect(sut.endDate).to(equal(endDate))
      }

      it("can be created from a closed range") {
        expect(startDate ..< endDate).to(equal(sut))
      }

      it("can be indexed using integers") {
        expect(sut[0]).to(equal(startDate))
        expect(sut[1]).to(equal(startDate + 1))
        expect(sut[4]).to(equal(endDate - 1))
      }

      it("can get the index of a calendar date") {
        expect(sut.firstIndex(of: startDate + 2)).to(equal(2))
      }

      it("can be instantiated using a last day instead of an end day") {
        let lastDate = endDate - 1
        let sut = CalendarDateRange(firstDate: startDate, lastIncludedDate: lastDate)
        expect(sut.startDate).to(equal(startDate))
        expect(sut.endDate).to(equal(endDate))
      }

      it("has a last date which precedes the end date") {
        let expected = endDate - 1
        expect(sut.lastIncludedDate).to(equal(expected))
      }

      context("when used as a collection") {

        it("always has a start index of 0") {
          expect(sut.startIndex).to(equal(0))
        }

        it("has a count equal to the number of days between start and end dates") {
          expect(sut.count).to(equal(5))
        }

        it("contains each date between the start and end date") {
          let expected = [
            try! CalendarDate(day: 5, month: 6, year: 2007),
            try! CalendarDate(day: 6, month: 6, year: 2007),
            try! CalendarDate(day: 7, month: 6, year: 2007),
            try! CalendarDate(day: 8, month: 6, year: 2007),
            try! CalendarDate(day: 9, month: 6, year: 2007)
          ]
          let result = sut.allCalendarDates
          expect(result).to(equal(expected))
        }

        it("can contain dates over a month boundary") {
          let sut = CalendarDateRange(startDate: try! CalendarDate(day: 29, month: 6, year: 2007),
                                      endDate: try! CalendarDate(day: 3, month: 7, year: 2007))
          let expected = [
            try! CalendarDate(day: 29, month: 6, year: 2007),
            try! CalendarDate(day: 30, month: 6, year: 2007),
            try! CalendarDate(day: 1, month: 7, year: 2007),
            try! CalendarDate(day: 2, month: 7, year: 2007)
            ]
          let result = sut.allCalendarDates
          expect(result).to(equal(expected))
        }

        it("can contain dates over a year boundary") {
          let sut = CalendarDateRange(startDate: try! CalendarDate(day: 30, month: 12, year: 2007),
                                      endDate: try! CalendarDate(day: 3, month: 1, year: 2008))
          let expected = [
            try! CalendarDate(day: 30, month: 12, year: 2007),
            try! CalendarDate(day: 31, month: 12, year: 2007),
            try! CalendarDate(day: 1, month: 1, year: 2008),
            try! CalendarDate(day: 2, month: 1, year: 2008)
            ]
          let result = sut.allCalendarDates
          expect(result).to(equal(expected))
        }
      }
    }
  }
}
