//
//  CalendarDateTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class CalendarDateTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Calendar Date") {

      let sut = try! CalendarDate(day: 5, month: 6, year: 2007)

      it("Uses the gregorian calendar in UTC time zone") {
        expect(CalendarDate.gregorianCalendar).to(equal(Calendar.gregorianInUTC))
      }

      it("contains a day, month and year") {
        expect(sut.day).to(equal(5))
        expect(sut.month).to(equal(6))
        expect(sut.year).to(equal(2007))
      }

//      it("cannot be instantiated with a malformed date") {
//        let error = CalendarDateError.malformedDate(day: 5, month: 13, year: 2007)
//        expect(try CalendarDate(day: 5, month: 13, year: 2007)).to(throwError(error))
//      }
//
//      it("malformed date error has readable description") {
//        let error = CalendarDateError.malformedDate(day: 5, month: 13, year: 2007)
//        expect(error.errorDescription).to(equal("Date is not valid 5/13/2007."))
//      }

      it("is equal to a CalendarDate representing the same day") {
        let other = try! CalendarDate(day: 5, month: 6, year: 2007)
        expect(sut).to(equal(other))
      }

      it("is not equal to a CalendarDate representing a different day") {
        let other = try! CalendarDate(day: 6, month: 6, year: 2007)
        expect(sut).notTo(equal(other))
      }

      it("can be converted to a date in a time zone") {
        let timezone = TimeZone(secondsFromGMT: 60 * 60)! // GMT+1
        let result = sut.dateInTimeZone(timeZone: timezone)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY HH:mm"
        dateFormatter.timeZone = timezone
        expect(dateFormatter.string(from: result)).to(equal("05/06/2007 00:00"))
      }

      it("can be created with a date and a time zone") {
        let timezone = TimeZone(secondsFromGMT: 60 * 60)! // GMT+1
        let expected = sut.dateInTimeZone(timeZone: timezone)
        let result = CalendarDate(date: expected, timeZone: timezone)
        expect(result).to(equal(sut))
      }

      it("can calculate the day of week") {
        expect(sut.dayOfWeek).to(equal(.tuesday))
        expect((sut + 1).dayOfWeek).to(equal(.wednesday))
        expect((sut + 2).dayOfWeek).to(equal(.thursday))
        expect((sut + 3).dayOfWeek).to(equal(.friday))
        expect((sut + 4).dayOfWeek).to(equal(.saturday))
        expect((sut + 5).dayOfWeek).to(equal(.sunday))
        expect((sut + 6).dayOfWeek).to(equal(.monday))
      }

      context("a day is added") {

        it("should represent the next day in a month") {
          let result = sut + 1
          let expectedDate = try! CalendarDate(day: 6, month: 6, year: 2007)
          expect(result).to(equal(expectedDate))
        }

        it("can add days using += infix operator") {
          var result = sut
          result += 5
          let expected = sut + 5
          expect(result).to(equal(expected))
        }

        context("to the last day of the month") {

          let lastDayOfTheMonth = try! CalendarDate(day: 30, month: 6, year: 2007)
          let result = lastDayOfTheMonth + 1

          it("should represent the next day in a year") {
            let expectedDate = try! CalendarDate(day: 1, month: 7, year: 2007)
            expect(result).to(equal(expectedDate))
          }
        }

        context("to the last day of the year") {

          let lastDayOfTheYear = try! CalendarDate(day: 31, month: 12, year: 2007)
          let result = lastDayOfTheYear + 1

          it("should represent the next day in an era") {
            let expectedDate = try! CalendarDate(day: 1, month: 1, year: 2008)
            expect(result).to(equal(expectedDate))
          }
        }
      }

      context("a day is subtracted") {

        let firstDayOfTheYear = try! CalendarDate(day: 1, month: 1, year: 2008)
        let result = firstDayOfTheYear - 1

        it("should represent the previous day") {
          let expectedDate = try! CalendarDate(day: 31, month: 12, year: 2007)
          expect(result).to(equal(expectedDate))
        }
      }

      context("when compared to another calendar date") {

        let otherDate = try! CalendarDate(day: 8, month: 6, year: 2007)

        it("is in the correct order") {
          expect(sut < otherDate).to(beTrue())
          expect(sut.isBefore(other: otherDate)).to(beTrue())

          expect(sut > otherDate).to(beFalse())
          expect(sut.isAfter(other: otherDate)).to(beFalse())

          expect(otherDate > sut).to(beTrue())
          expect(otherDate.isAfter(other: sut)).to(beTrue())

          expect(otherDate < sut).to(beFalse())
          expect(otherDate.isBefore(other: sut)).to(beFalse())
        }

        context("when taking the difference") {
          it("should return the number of days between the dates") {
            let difference = otherDate - sut
            expect(difference).to(equal(3))
          }

          it("should return the number of days when dates span over a month boundary") {
            let otherDate = try! CalendarDate(day: 5, month: 7, year: 2007)
            let difference = otherDate - sut
            expect(difference).to(equal(30))
          }
        }

//        it("should conform to the Codable protocol") {
//          let encoder = PropertyListEncoder()
//          guard let data = try? encoder.encode(["value": sut]) else {
//            return XCTFail("Failed to encode CalendarDate")
//          }
//          let decoder = PropertyListDecoder()
//          guard let result = try? decoder.decode([String: CalendarDate].self, from: data) else {
//            return XCTFail("Failed to decode CalendarDate")
//          }
//          expect(result["value"]).to(equal(sut))
//        }
      }
    }
  }
}

//final class CalendarDateErrorTests: QuickSpec {
//  override func spec() {
//    super.spec()
//    describe("CalendarDateError") {
//      it("should return false when comparing two different calendar dates") {
//        let error1 = CalendarDateError.malformedDate(day: 1, month: 2, year: 3)
//        let error2 = CalendarDateError.malformedDate(day: 4, month: 5, year: 6)
//        expect(error1).toNot(equal(error2))
//      }
//
//      it("should return true when comparing two of the same calendar dates") {
//        let error1 = CalendarDateError.malformedDate(day: 1, month: 2, year: 3)
//        let error2 = CalendarDateError.malformedDate(day: 1, month: 2, year: 3)
//        expect(error1).to(equal(error2))
//      }
//    }
//  }
//}
