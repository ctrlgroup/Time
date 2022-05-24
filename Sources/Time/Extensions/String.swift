//
//  String.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

extension StringProtocol {
  func asIntFromAsciiRepresentation() -> Int? {
    return Int(self)
  }
}

extension String {
  var nsRange: NSRange {
    return NSRange(location: 0, length: (self as NSString).length)
  }

  subscript(range: NSRange) -> String {
    return (self as NSString).substring(with: range)
  }
}
