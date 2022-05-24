//
//  DateTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation
import XCTest
import Quick
import Nimble
import Time

final class DateTests: QuickSpec {
  override func spec() {
    describe("date extensions") {

      it("will return tomorrows date by adding 1 day") {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "MM/dd/YY"

        let today = Date(timeIntervalSince1970: 1511438400)
        let tomorrow = today.addDays(days: 1)
        let tomorrowString = formatter.string(from: tomorrow)
        expect(tomorrowString).to(equal("11/24/17"))
      }

      it("can count the number of days before another date") {
        let date1 = Date()
        let date2 = Date(timeIntervalSinceNow: .day * 5)
        let result = date1.numberOfDays(before: date2)
        expect(result).to(equal(5))
      }
    }
  }
}
