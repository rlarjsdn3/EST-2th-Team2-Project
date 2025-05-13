//
//  Diary.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import Foundation
import SwiftData

// 하위 엔터티(Diary)
@Model
final class Diary {
    /// 다이어리의 제목을 나타내는 문자열입니다.
    var title: String
    /// 다이어리의 내용을 나타내는 문자열입니다.
    var contents: String
    /// 다이어리에 연결된 카테고리 목록입니다.
    /// - Note: 카테고리가 삭제될 경우, 다이어리에서 해당 카테고리에 대한 참조를 무효화합니다. (nullify)
    @Relationship(deleteRule: .nullify, inverse: \Category.diaries)
    var categories: [Category]
    /// 다이어리 작성 날짜를 나타내는 Date 객체입니다.
    var createdDate: Date

    /// Diary 모델의 초기화 메서드입니다.
    /// - Parameters:
    ///   - title: 다이어리의 제목
    ///   - contents: 다이어리의 내용
    ///   - categories: 다이어리에 연결할 카테고리 목록
    ///   - date: 다이어리 작성 날짜
    init(title: String, contents: String, categories: [Category], createdDate: Date = .now) {
        self.title = title
        self.contents = contents
        self.categories = categories
        self.createdDate = createdDate
    }
}


extension Diary {

    /// Random mock 데이터 생성기입니다.
    /// 추후, 시연 가능한 데이터 생성기로 대체될 예정입니다.
    /// 대체 시, 밑의 Date Extenstion도 제거 바랍니다.
    static let mock: [Diary] = (1...20).map { i in
        let base = "Diary Test \(i)"
        let repeatCount = Int.random(in: 10...30)
        let randomContents = Array(repeating: base, count: repeatCount).joined(separator: " ")

        let categoryCount = Int.random(in: 1...4)
        let randomCategories = Category.mock.shuffled().prefix(categoryCount)

        return Diary(
            title: "Diary Test \(i)",
            contents: randomContents,
            categories: Array(randomCategories),
            createdDate: Date.random(
                from: DateComponents(calendar: .current, year: 2024, month: 12, day: 1),
                to: DateComponents(calendar: .current, year: 2025, month: 05, day: 3)
            )
        )
    }


}

/// Random Mock 데이터 생성기에서 사용하는 랜덤 날짜 선택기입니다.
/// Random 데이터 생성기가 대체될 때, 같이 제거해주세요.
extension Date {
    static func random(from start: DateComponents, to end: DateComponents) -> Date {
        let calendar = Calendar.current
        guard let startDate = calendar.date(from: start),
              let endDate = calendar.date(from: end) else {
            return .now
        }
        let interval = endDate.timeIntervalSince(startDate)
        let randomOffset = TimeInterval.random(in: 0...interval)
        return startDate.addingTimeInterval(randomOffset)
    }
}
