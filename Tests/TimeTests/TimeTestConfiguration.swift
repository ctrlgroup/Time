//
//  TimeTestConfiguration.swift
//  TimeTests
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Quick
@testable import Time
import Resolver

/// Sets up global configuration for every test.
final class TimeTestConfiguration: QuickConfiguration {
  override class func configure(_ configuration: Configuration!) {
    configuration.beforeEach {
      let mock = Resolver(child: .root)
      mock.registerServices()
      Resolver.root = mock
    }
  }
}
