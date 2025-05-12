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
