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

    static let mock: [Diary] = [
        Diary(
            title: "임의 침묵",
            contents: "님은 갔습니다. 아아, 사랑하는 나의 님은 갔습니다. 푸른 산빛을 깨치고 단풍나무 숲을 향하여 난 작은 길을 걸어서, 차마 떨치고 갔습니다.",
            categories: [.mock[0], .mock[1], .mock[2]]
        ),
        Diary(
            title: "진달래꽃",
            contents: "나 보기가 역겨워 가실 때에는 말없이 고이보내 드리우리다. 영변에 약산 진달래꽃 아름 따다 가실 길에 뿌리우리다.",
            categories: [.mock[1], .mock[3], .mock[4]]
        ),
        Diary(
            title: "두 다리 매(투 호크스)의 할이버지(라코타 족)",
            contents: "위대한 정령께서는 당신에게 두 개의 귀를 주셨지만, 입은 하나만 주셨다. 그것은 당신이 말하는 것보다 두 배나 많이 귀 기울여 들으라는 뜻이다.",
            categories: []
        ),
        Diary(
            title: "흰 방패(워파헤바) 추장이 한 말",
            contents: "나는 늙었다. 그것은 사실이다. 그러나 사실을 똑바로 바라보지 못할 만큼 늙지는 않았다. 당신들이 나를 늙은 바보에 불과하다고 말해도 좋다. 나는 백 번이라도 얼굴 붉은 늙은 바보가 되고 싶지, 당신들처럼 얼굴 흰 도둑놈이 되고 싶진 않다.",
            categories: [.mock[0],.mock[3]]
        ),
        Diary(
            title: "어떻게 공기를 사고판단 말인가",
            contents: "우리가 어떻게 공기를 사고팔 수 있단 말인가? 대지의 따뜻함을 어떻게 사고판단 말인가? 우리로서는 상상하기조차 어려운 일이다. 부드러운 공기와 재잘거리는 시냇물을 우리가 어떻게 소유할 수 있으며, 또한 소유하지도 않은 것을 어떻게 사고팔 수 있단 말인가?",
            categories: [.mock[2], .mock[4]],
        )
    ]
}
