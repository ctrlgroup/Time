//
//  CalendarTests.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import XCTest
@testable import Time
import Quick
import Nimble

final class CalendarTests: QuickSpec {
  override func spec() {
    super.spec()
    describe("Calendar extensions") {
      it("should have a static gregorian calendar in UTC") {
        let sut = Calendar.gregorianInUTC
        expect(sut.identifier).to(equal(.gregorian))
        expect(sut.timeZone).to(equal(.utc))
      }
    }
  }
}
