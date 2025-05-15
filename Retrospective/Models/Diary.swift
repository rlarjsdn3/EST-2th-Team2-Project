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
            contents: "님님은 갔습니다 아아 사랑하는 나의 님은 갔습니다 푸른 산빛을 깨치고 단풍나무 숲을 향하여 난 작은 길을 걸어서 차마 떨치고 갔습니다 나는 눈물 속에 님의 뒷모습을 지켜보았습니다 한 발 또 한 발 바스락이는 낙엽 위로 님은 아무 말 없이 떠났습니다 내 마음의 문을 두드리던 따뜻한 손길도 그 마지막 인사조차 남기지 않았습니다 산새도 잠시 울음을 멈추고 나무들도 바람을 붙잡은 듯 고요했습니다 그 길은 짧았지만 영원처럼 멀게 느껴졌고 나는 발을 떼지 못한 채 그 자리에 서 있었습니다",
            categories: [.mock[0], .mock[1], .mock[2]],
            createdDate: Date(year: 2025, month: 5, day: 13)!
        ),
        Diary(
            title: "아침의 햇살",
            contents: "어느 아침, 햇살이 창을 가득 채웠습니다. 그 빛은 나를 따뜻하게 감싸며, 새로운 하루를 맞이할 용기를 주었습니다.",
            categories: [],
            createdDate: Date(year: 2025, month: 5, day: 13)!
        ),
        Diary(
            title: "내용에만 있어요.",
            contents: "따뜻한 햇살과 꽃향기가 가득한 봄, 주말마다 가까운 도시로 소소한 여행을 떠나요. 벚꽃 구경도 하고, 한적한 시골 마을도 걸어요. 짧은 여행이지만 마음이 환기되는 시간이 돼요.",
            categories: [.mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 11)!
        ),
        Diary(
            title: "봄에는 여행을 가요",
            contents: "따뜻한 햇살과 꽃향기가 가득한 여름, 주말마다 가까운 도시로 소소한 여행을 떠나요. 벚꽃 구경도 하고, 한적한 시골 마을도 걸어요. 짧은 여행이지만 마음이 환기되는 시간이 돼요.",
            categories: [.mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 11)!
        ),
        Diary(
            title: "가을의 여운",
            contents: "노랗고 붉은 잎들이 바람에 흩날립니다. 차가운 공기가 볼을 스치고, 나는 그 안에서 따뜻함을 찾습니다.",
            categories: [.mock[2], .mock[7]],
            createdDate: Date(year: 2025, month: 5, day: 10)!
        ),
        Diary(
            title: "별빛 아래",
            contents: "밤하늘을 올려다보며 무수히 빛나는 별들을 바라봤습니다. 그 빛은 멀리서도 나를 지켜보고 있었습니다.",
            categories: [.mock[3], .mock[8]],
            createdDate: Date(year: 2025, month: 5, day: 9)!
        ),
        Diary(
            title: "비 오는 날의 생각",
            contents: "빗방울이 창문을 두드리며, 내 마음도 함께 적셔집니다. 차분한 빗소리 속에서 깊은 생각에 잠겼습니다.",
            categories: [.mock[0], .mock[5]],
            createdDate: Date(year: 2025, month: 5, day: 9)!
        ),
        Diary(
            title: "도시의 불빛",
            contents: "화려한 네온사인 아래, 사람들의 웃음소리와 발걸음이 어우러집니다. 나는 그 속에서 잠시 멈춰 섰습니다.",
            categories: [.mock[1], .mock[4], .mock[9]],
            createdDate: Date(year: 2025, month: 5, day: 9)!
        ),
        Diary(
            title: "산책로의 고요함",
            contents: "푸른 잎사귀 사이로 바람이 불어옵니다. 산책로를 걷다 보면 마음이 차분해지고, 자유로워집니다.",
            categories: [.mock[3], .mock[7]],
            createdDate: Date(year: 2025, month: 5, day: 6)!
        ),
        Diary(
            title: "향긋한 커피 한 잔",
            contents: "아침 커피의 향기가 하루를 시작하는 힘을 줍니다. 따뜻한 한 모금이 내 마음을 녹여줍니다.",
            categories: [.mock[0], .mock[2], .mock[6]],
            createdDate: Date(year: 2025, month: 5, day: 5)!
        ),
        Diary(
            title: "소나기",
            contents: "갑자기 쏟아진 소나기에 옷이 젖었지만, 마음은 상쾌했습니다. 차가운 빗방울이 나를 깨워줍니다.",
            categories: [.mock[0], .mock[1], .mock[4]],
            createdDate: Date(year: 2025, month: 5, day: 4)!
        ),
        Diary(
            title: "은은한 달빛",
            contents: "밤하늘에 걸린 은은한 달빛이 내 방을 부드럽게 비춥니다. 그 빛 아래에서 마음이 차분해집니다.",
            categories: [.mock[2], .mock[5], .mock[8]],
            createdDate: Date(year: 2025, month: 5, day: 3)!
        ),
        Diary(
            title: "고요한 새벽",
            contents: "모두가 잠든 시간, 새벽의 고요함이 나를 감쌉니다. 혼자만의 시간이 소중하게 느껴집니다.",
            categories: [.mock[1], .mock[6]],
            createdDate: Date(year: 2025, month: 5, day: 2)!
        ),
        Diary(
            title: "여행의 추억",
            contents: "낯선 거리를 걸으며 만났던 사람들, 맛있었던 음식, 그리고 아름다운 풍경들이 눈앞에 생생히 떠오릅니다.",
            categories: [.mock[0], .mock[2], .mock[7]],
            createdDate: Date(year: 2025, month: 5, day: 1)!
        ),
        Diary(
            title: "봄에는 축구를 해요",
            contents: "날씨가 선선해지면 친구들과 공원에 모여 축구를 해요. 땀이 나도 기분 좋은 계절이라 더 열심히 뛰게 돼요. 팀을 나눠서 미니 게임을 하며 스트레스를 날려요.",
            categories: [.mock[1]],
            createdDate: Date(year: 2025, month: 4, day: 25)!
        ),
        Diary(
            title: "고양이와의 만남",
            contents: "골목길에서 만난 작은 고양이가 내 발밑에 와서 몸을 비볐습니다. 따뜻한 온기가 전해졌습니다.",
            categories: [.mock[4], .mock[9]],
            createdDate: Date(year: 2025, month: 4, day: 22)!
        ),
        Diary(
            title: "도서관에서의 시간",
            contents: "조용한 도서관에서 책을 읽으며 마음이 차분해졌습니다. 지식의 향기를 느낄 수 있었습니다.",
            categories: [.mock[3], .mock[6], .mock[8]],
            createdDate: Date(year: 2025, month: 4, day: 19)!
        ),
        Diary(
            title: "커피 향 가득한 카페",
            contents: "따뜻한 커피 한 잔을 마시며 창밖을 바라봤습니다. 사람들의 움직임을 보며 생각에 잠겼습니다.",
            categories: [.mock[0], .mock[5], .mock[9]],
            createdDate: Date(year: 2025, month: 4, day: 18)!
        ),
        Diary(
            title: "봄에는 집에 있어요",
            contents: "여름이면 바깥도 좋지만, 오히려 조용한 집에서 쉬는 시간이 더 좋아요. 창문을 열면 바람과 햇살이 들어오고, 따뜻한 차 한 잔과 책 한 권이면 완벽한 하루가 돼요.",
            categories: [.mock[9]],
            createdDate: Date(year: 2025, month: 4, day: 18)!
        ),
        Diary(
            title: "공원에서의 피크닉",
            contents: "푸른 잔디에 돗자리를 펴고, 간단한 간식을 먹으며 여유로운 시간을 보냈습니다.",
            categories: [.mock[4], .mock[8]],
            createdDate: Date(year: 2025, month: 4, day: 17)!
        ),
        Diary(
            title: "밤의 산책로",
            contents: "어둠 속에서도 은은하게 빛나는 가로등 아래를 걸으며, 고요함을 만끽했습니다.",
            categories: [.mock[3], .mock[7]],
            createdDate: Date(year: 2025, month: 4, day: 16)!
        )
    ]
}
