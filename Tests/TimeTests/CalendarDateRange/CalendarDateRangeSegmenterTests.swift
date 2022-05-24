//
//  ReportSegmenterTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
import Quick
import Nimble
import Time

final class CalendarDateRangeSegmenterTests: QuickSpec {
  override func spec() {
    describe("Report segmenter") {

      let date = try! CalendarDate(day: 29, month: 01, year: 2019)

      it("should not divide the range if the segment is larger than the original date range") {
        let dateRange = CalendarDateRange(firstDate: date - 5, lastIncludedDate: date)
        let sut = CalendarDateRangeSegmenter(dateRangeToSegment: dateRange, intoSegmentsOfSize: 6)
        let result = sut.divideDateRange()
        expect(result.count).to(equal(1))
      }

      context("segment 2 weeks into 7 days segments") {

        let totalNumberOfDays = 14
        let segmentSize = 7
        let dateRange = CalendarDateRange(firstDate: date - (totalNumberOfDays - 1),
                                          lastIncludedDate: date)
        let sut = CalendarDateRangeSegmenter(dateRangeToSegment: dateRange,
                                             intoSegmentsOfSize: segmentSize)

        let result = sut.divideDateRange()

        it("should divide the date range into 2 weeks") {

          let endOfFirstRange = date - 7
          let startOfSecondRange = date - 6

          let expectedRange1 = CalendarDateRange(firstDate: dateRange.startDate,
                                                 lastIncludedDate: endOfFirstRange)
          let expectedRange2 = CalendarDateRange(firstDate: startOfSecondRange,
                                                 lastIncludedDate: dateRange.lastIncludedDate)

          expect(result.count).to(equal(2))

          // Doing this so I don't have to force unwrap.
          // The test will fail (due to the previous assertion) if this is not possible.
          guard
            let firstRange = result.first,
            let secondRange = result.last else {
            return
          }

          expect(firstRange).to(equal(expectedRange1))
          expect(secondRange).to(equal(expectedRange2))
        }
      }

      context("days in study do not divide into weeks exactly") {

        let totalNumberOfDays = 16
        let segmentSize = 7
        let dateRange = CalendarDateRange(firstDate: date - (totalNumberOfDays - 1),
                                          lastIncludedDate: date)
        let sut = CalendarDateRangeSegmenter(dateRangeToSegment: dateRange,
                                             intoSegmentsOfSize: segmentSize)

        let result = sut.divideDateRange()

        it("should put remainder days in first week") {

          expect(result.count).to(equal(3))
          expect(result[0].startDate).to(equal(dateRange.startDate))
          expect(result[0].lastIncludedDate).to(equal(date - 14))

          expect(result[1].startDate).to(equal(date - 13))
          expect(result[1].lastIncludedDate).to(equal(date - 7))

          expect(result[2].startDate).to(equal(date - 6))
          expect(result[2].lastIncludedDate).to(equal(date))
        }
      }

      context("there are less than 7 days") {
        let totalNumberOfDays = 5
        let segmentSize = 7
        let dateRange = CalendarDateRange(firstDate: date - (totalNumberOfDays - 1),
                                          lastIncludedDate: date)
        let sut = CalendarDateRangeSegmenter(dateRangeToSegment: dateRange,
                                             intoSegmentsOfSize: segmentSize)

        let result = sut.divideDateRange()

        it("should not add padding days") {
          expect(result.count).to(equal(1))
          expect(result[0].startDate).to(equal(date - 4))
          expect(result[0].lastIncludedDate).to(equal(date))
        }
      }
    }
  }
}
