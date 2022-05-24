//
//  Array.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

extension Array {
  @discardableResult
  mutating func shift() -> Element? {
    guard let first = first else {
      return nil
    }

    self = Array(dropFirst())
    return first
  }
}
