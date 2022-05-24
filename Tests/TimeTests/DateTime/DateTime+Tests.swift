//
//  DateTime+Tests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
@testable import Time
import Quick
import Nimble

final class DateTimeTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("DateTime") {

      let calendarDate = try! CalendarDate(day: 01, month: 02, year: 2003)
      let timeOfDay = 01⁝02⁝03
      let sut = DateTime(calendarDate: calendarDate, timeOfDay: timeOfDay)
      let date = Date(timeIntervalSince1970: 1044061323)

      it("will create a Date for a DateTime") {
        let result = sut.date(in: .utc)
        expect(result).to(equal(date))
      }
    }
  }
}
