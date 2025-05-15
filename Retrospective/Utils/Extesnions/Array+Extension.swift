//
//  Array+Extension.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//

import SwiftUI

extension Array where Element == Diary {
    /// `Diary` 배열을 월별 → 일별로 그룹화합니다.
    ///
    /// 이 메서드는 배열의 각 `Diary`를 `createdDate` 기준으로 먼저 `"YYYY.MM"` 형식의 월 단위로 그룹화하고,
    /// 그 다음 각 월 그룹을 `"DD일 (요일)"` 형식의 일 단위로 중첩 그룹화하여 2단계 딕셔너리로 반환합니다.
    ///
    /// - Returns: `[String: [String: [Diary]]]`
    ///   - 첫 번째 키: `"YYYY.MM"` 형식의 월 문자열
    ///   - 두 번째 키: `"DD일 (요일)"` 형식의 일 문자열
    ///   - 값: 해당 날짜에 작성된 `Diary` 객체 배열
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

    /// 요일 정수를 요일 문자열로 변환합니다.
    ///
    /// - Parameter weekday: 1(Sunday) ~ 7(Saturday)
    /// - Returns: "Sun", "Mon", "Tue" 등 요일 문자열
    private static func weekdayName(_ weekday: Int) -> String {
        let symbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return symbols[(weekday - 1 + 7) % 7]
    }
}


extension Array {
    
    /// <#Description#>
    /// - Parameter convertToArrayImmediately: <#convertToArrayImmediately description#>
    /// - Returns: <#description#>
    func prefix(length convertToArrayImmediately: Int) -> Array<Element> {
        Array(self.prefix(convertToArrayImmediately))
    }
}
