//
//  Item.swift
//  SwiftDataExample
//
//  Created by 김건우 on 5/12/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

extension Item {

    static let mock: [Item] = [
        .init(timestamp: Date()),
        .init(timestamp: Date(timeIntervalSinceNow: -1)),
        .init(timestamp: Date(timeIntervalSinceNow: -2)),
        .init(timestamp: Date(timeIntervalSinceNow: -3)),
        .init(timestamp: Date(timeIntervalSinceNow: -4)),
        .init(timestamp: Date(timeIntervalSinceNow: -5)),
        .init(timestamp: Date(timeIntervalSinceNow: -6)),
        .init(timestamp: Date(timeIntervalSinceNow: -7)),
        .init(timestamp: Date(timeIntervalSinceNow: -8)),
        .init(timestamp: Date(timeIntervalSinceNow: -9)),
        .init(timestamp: Date(timeIntervalSinceNow: -10)),
    ]
}
