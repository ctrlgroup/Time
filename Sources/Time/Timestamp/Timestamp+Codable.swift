//
//  Timestamp+Codable.swift
//  Time
//
//  Copyright © 2022 Ctrl Group Ltd. All rights reserved.
//  MIT license, see LICENSE file for details
//

import Foundation

extension Timestamp: Codable {

  private enum CodingKeys: CodingKey {
    case date, timestamp, timeZone
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // Support for existing archives of timestamp which are keyed as `date`
    if let date = try container.decodeIfPresent(Date.self, forKey: .date) {
      self.date = date
    } else {
      self.date = try container.decode(Date.self, forKey: .timestamp)
    }

    if let timeZoneIndentifier = try? container.decode(String.self, forKey: .timeZone) {
      guard let timeZone = TimeZone(identifier: timeZoneIndentifier) else {
        throw DecodingError.dataCorruptedError(forKey: .timeZone,
                                               in: container,
                                               debugDescription: "Not a valid time zone identifier")
      }
      self.timeZone = timeZone
    } else {
      self.timeZone = try container.decode(TimeZone.self, forKey: .timeZone)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(date, forKey: .timestamp)
    try container.encode(timeZone.identifier, forKey: .timeZone)
  }
}
