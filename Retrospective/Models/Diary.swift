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
            categories: [.mock[0], .mock[1], .mock[2]],
            createdDate: Date(year: 2025, month: 5, day: 13)!
        ),
        Diary(
            title: "아침의 햇살",
            contents: "어느 아침, 햇살이 창을 가득 채웠습니다. 그 빛은 나를 따뜻하게 감싸며, 새로운 하루를 맞이할 용기를 주었습니다.",
            categories: [.mock[1], .mock[2]],
            createdDate: Date(year: 2025, month: 5, day: 13)!
        ),
        Diary(
            title: "봄의 노래",
            contents: "새싹이 돋아나는 소리, 부드러운 바람이 불어옵니다. 꽃들은 피어나며 향기를 퍼트리고, 나는 그 속에서 미소 지었습니다.",
            categories: [.mock[0], .mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 11)!
        ),
        Diary(
            title: "가을의 여운",
            contents: "노랗고 붉은 잎들이 바람에 흩날립니다. 차가운 공기가 볼을 스치고, 나는 그 안에서 따뜻함을 찾습니다.",
            categories: [.mock[2], .mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 10)!
        ),
        Diary(
            title: "별빛 아래",
            contents: "밤하늘을 올려다보며 무수히 빛나는 별들을 바라봤습니다. 그 빛은 멀리서도 나를 지켜보고 있었습니다.",
            categories: [.mock[1], .mock[4]],
            createdDate: Date(year: 2025, month: 5, day: 9)!
        ),
        Diary(
            title: "비 오는 날의 생각",
            contents: "빗방울이 창문을 두드리며, 내 마음도 함께 적셔집니다. 차분한 빗소리 속에서 깊은 생각에 잠겼습니다.",
            categories: [.mock[0]],
            createdDate: Date(year: 2025, month: 5, day: 9)!
        ),
        Diary(
            title: "도시의 불빛",
            contents: "화려한 네온사인 아래, 사람들의 웃음소리와 발걸음이 어우러집니다. 나는 그 속에서 잠시 멈춰 섰습니다.",
            categories: [.mock[2]],
            createdDate: Date(year: 2025, month: 5, day: 7)!
        ),
        Diary(
            title: "산책로의 고요함",
            contents: "푸른 잎사귀 사이로 바람이 불어옵니다. 산책로를 걷다 보면 마음이 차분해지고, 자유로워집니다.",
            categories: [.mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 6)!
        ),
        Diary(
            title: "향긋한 커피 한 잔",
            contents: "아침 커피의 향기가 하루를 시작하는 힘을 줍니다. 따뜻한 한 모금이 내 마음을 녹여줍니다.",
            categories: [.mock[1]],
            createdDate: Date(year: 2025, month: 5, day: 5)!
        ),
        Diary(
            title: "소나기",
            contents: "갑자기 쏟아진 소나기에 옷이 젖었지만, 마음은 상쾌했습니다. 차가운 빗방울이 나를 깨워줍니다.",
            categories: [.mock[0], .mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 4)!
        ),
        Diary(
            title: "은은한 달빛",
            contents: "밤하늘에 걸린 은은한 달빛이 내 방을 부드럽게 비춥니다. 그 빛 아래에서 마음이 차분해집니다.",
            categories: [.mock[2], .mock[3]],
            createdDate: Date(year: 2025, month: 5, day: 3)!
        ),
        Diary(
            title: "고요한 새벽",
            contents: "모두가 잠든 시간, 새벽의 고요함이 나를 감쌉니다. 혼자만의 시간이 소중하게 느껴집니다.",
            categories: [.mock[1]],
            createdDate: Date(year: 2025, month: 5, day: 2)!
        ),
        Diary(
            title: "여행의 추억",
            contents: "낯선 거리를 걸으며 만났던 사람들, 맛있었던 음식, 그리고 아름다운 풍경들이 눈앞에 생생히 떠오릅니다.",
            categories: [.mock[0], .mock[1]],
            createdDate: Date(year: 2025, month: 5, day: 1)!
        ),
        Diary(
            title: "겨울의 첫눈",
            contents: "하늘에서 내리는 첫눈을 바라보며 어린 시절의 기억이 떠올랐습니다. 흰 눈이 모든 것을 덮어줍니다.",
            categories: [.mock[2]],
            createdDate: Date(year: 2025, month: 4, day: 30)!
        ),
        Diary(
            title: "따뜻한 차 한 잔",
            contents: "따뜻한 차 한 잔을 마시며 마음을 녹입니다. 향기로운 차 향이 나를 차분하게 만들어줍니다.",
            categories: [.mock[3]],
            createdDate: Date(year: 2025, month: 4, day: 29)!
        ),
        Diary(
            title: "바다의 소리",
            contents: "파도 소리가 귓가를 울립니다. 넓은 바다를 바라보며 마음이 넓어지고, 고민이 사라집니다.",
            categories: [.mock[0]],
            createdDate: Date(year: 2025, month: 4, day: 28)!
        ),
        Diary(
            title: "따뜻한 미소",
            contents: "누군가의 따뜻한 미소가 나를 웃게 만듭니다. 작은 미소가 큰 행복을 만들어줍니다.",
            categories: [.mock[1]],
            createdDate: Date(year: 2025, month: 4, day: 27)!
        ),
        Diary(
            title: "황혼의 노을",
            contents: "하늘을 물들이는 붉은 노을을 바라보며 하루의 끝을 맞이합니다. 아름다움 속에서 마음이 차분해집니다.",
            categories: [.mock[2]],
            createdDate: Date(year: 2025, month: 4, day: 26)!
        ),
        Diary(
            title: "초여름의 산들바람",
            contents: "초여름의 산들바람이 내 얼굴을 스쳐갑니다. 따뜻하면서도 상쾌한 바람이 기분 좋습니다.",
            categories: [.mock[4]],
            createdDate: Date(year: 2025, month: 4, day: 25)!
        ),
        Diary(
            title: "정원의 꽃들",
            contents: "정원에 피어난 꽃들이 다양한 색으로 물들어 있습니다. 꽃잎을 바라보며 마음이 밝아집니다.",
            categories: [.mock[0]],
            createdDate: Date(year: 2025, month: 4, day: 24)!
        ),
        Diary(
            title: "진달래꽃",
            contents: "나 보기가 역겨워 가실 때에는 말없이 고이보내 드리우리다. 영변에 약산 진달래꽃 아름 따다 가실 길에 뿌리우리다.",
            categories: [.mock[1], .mock[3], .mock[4]],
            createdDate: Date(year: 2025, month: 4, day: 24)!
        ),
        Diary(
            title: "위대한 정령",
            contents: "위대한 정령께서는 당신에게 두 개의 귀를 주셨지만, 입은 하나만 주셨다. 그것은 당신이 말하는 것보다 두 배나 많이 귀 기울여 들으라는 뜻이다.",
            categories: [],
            createdDate: Date(year: 2025, month: 4, day: 24)!
        ),
        Diary(
            title: "얼굴 흰 도둑놈",
            contents: "나는 늙었다. 그것은 사실이다. 그러나 사실을 똑바로 바라보지 못할 만큼 늙지는 않았다. 나는 백 번이라도 얼굴 붉은 늙은 바보가 되고 싶지, 당신들처럼 얼굴 흰 도둑놈이 되고 싶진 않다.",
            categories: [.mock[0],.mock[3]],
            createdDate: Date(year: 2025, month: 4, day: 24)!
        ),
        Diary(
            title: "어떻게 공기를 사고판단 말인가",
            contents: "부드러운 공기와 재잘거리는 시냇물을 우리가 어떻게 소유할 수 있으며, 또한 소유하지도 않은 것을 어떻게 사고팔 수 있단 말인가?",
            categories: [.mock[2], .mock[4]],
            createdDate: Date(year: 2025, month: 4, day: 24)!
        ),
        Diary(
            title: "여름 밤의 산책",
            contents: "더운 여름 밤, 시원한 바람을 맞으며 한적한 길을 걸었습니다. 달빛이 어두운 길을 밝혀주었습니다.",
            categories: [.mock[1], .mock[2]],
            createdDate: Date(year: 2025, month: 4, day: 23)!
        ),
        Diary(
            title: "고양이와의 만남",
            contents: "골목길에서 만난 작은 고양이가 내 발밑에 와서 몸을 비볐습니다. 따뜻한 온기가 전해졌습니다.",
            categories: [.mock[0], .mock[3]],
            createdDate: Date(year: 2025, month: 4, day: 22)!
        ),
        Diary(
            title: "친구와의 대화",
            contents: "오랜만에 친구와 만나 깊은 이야기를 나눴습니다. 서로의 고민을 나누며 마음이 가벼워졌습니다.",
            categories: [.mock[1]],
            createdDate: Date(year: 2025, month: 4, day: 21)!
        ),
        Diary(
            title: "파란 하늘",
            contents: "구름 한 점 없이 맑은 하늘이 펼쳐졌습니다. 그 파란색은 마음을 시원하게 만들어줍니다.",
            categories: [.mock[3]],
            createdDate: Date(year: 2025, month: 4, day: 20)!
        ),
        Diary(
            title: "도서관에서의 시간",
            contents: "조용한 도서관에서 책을 읽으며 마음이 차분해졌습니다. 지식의 향기를 느낄 수 있었습니다.",
            categories: [.mock[2]],
            createdDate: Date(year: 2025, month: 4, day: 19)!
        ),
        Diary(
            title: "커피 향 가득한 카페",
            contents: "따뜻한 커피 한 잔을 마시며 창밖을 바라봤습니다. 사람들의 움직임을 보며 생각에 잠겼습니다.",
            categories: [.mock[0]],
            createdDate: Date(year: 2025, month: 4, day: 18)!
        ),
        Diary(
            title: "공원에서의 피크닉",
            contents: "푸른 잔디에 돗자리를 펴고, 간단한 간식을 먹으며 여유로운 시간을 보냈습니다.",
            categories: [.mock[4], .mock[2]],
            createdDate: Date(year: 2025, month: 4, day: 17)!
        ),
        Diary(
            title: "밤의 산책로",
            contents: "어둠 속에서도 은은하게 빛나는 가로등 아래를 걸으며, 고요함을 만끽했습니다.",
            categories: [.mock[3]],
            createdDate: Date(year: 2025, month: 4, day: 16)!
        ),
        Diary(
            title: "새로운 취미",
            contents: "처음으로 그림을 그려봤습니다. 서툴지만 색을 채워가는 재미에 푹 빠졌습니다.",
            categories: [.mock[2], .mock[3]],
            createdDate: Date(year: 2025, month: 4, day: 15)!
        ),
        Diary(
            title: "소소한 행복",
            contents: "작은 꽃 한 송이가 피어 있는 걸 발견했습니다. 그 작은 생명에서 큰 기쁨을 느꼈습니다.",
            categories: [.mock[0], .mock[4]],
            createdDate: Date(year: 2025, month: 4, day: 14)!

        )
    ]
}
