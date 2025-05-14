//
//  Array+Extension.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//

import SwiftUI

extension Array where Element == Diary {
    func groupByMonthAndDay() -> [String: [String: [Diary]]] {
        let calendar = Calendar.current

        return Dictionary(grouping: self) { diary in
            let components = calendar.dateComponents([.year, .month, .day, .weekday], from: diary.createdDate)
            return String(format: "%04d.%02d", components.year!, components.month!)
        }.mapValues { monthGroup in
            Dictionary(grouping: monthGroup) { diary in
                let components = calendar.dateComponents([.month, .day, .weekday], from: diary.createdDate)
                return String(format: "%02d일 (%@)", components.day!, Self.weekdayName(components.weekday!))
            }
        }
    }

    private static func weekdayName(_ weekday: Int) -> String {
        let symbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return symbols[(weekday - 1 + 7) % 7]
    }
}
