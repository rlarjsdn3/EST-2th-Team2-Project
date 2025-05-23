//
//  Category.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI
import SwiftData



/*
 * 📌 엔터티 간 관계 다이어그램 (N:N)
 *
 * ┌───────────────┐        ┌───────────────┐
 * │   Category    │ *    * │    Diary      │
 * │───────────────│<------>│───────────────│
 * │ - name        │        │ - title       │
 * │ - red         │        │ - content     │
 * │ - green       │        │ - createdDate │
 * │ - blue        │        │───────────────│
 * │───────────────│        │ + categories  │
 * │ + diaries     │        │               │
 * └───────────────┘        └───────────────┘
 *
 * - N:N (다대다) 관계:
 *   - 각 Category는 여러 Diary에 연결될 수 있으며,
 *     각 Diary도 여러 Category에 연결될 수 있습니다.
 * - Category → Diary:
 *   - 카테고리는 여러 다이어리를 참조할 수 있으며,
 *     다이어리 삭제 시 해당 참조는 무효화(nullify)됩니다.
 * - Diary → Category:
 *   - 다이어리는 여러 카테고리를 참조할 수 있으며,
 *     카테고리 삭제 시 해당 참조는 무효화(nullify)됩니다.
 */


// 상위 엔터티(Category)
@Model
final class Category {
    /// 카테고리의 고유 이름을 나타내는 속성입니다.
    /// - Note: 각 카테고리의 이름은 중복될 수 없으며, 고유해야 합니다.
    @Attribute(.unique) var name: String
    /// 카테고리의 색상에서 빨간색(Red) 구성 요소 값 (0 ~ 255)입니다.
    private var red: Double
    /// 카테고리의 색상에서 초록색(Green) 구성 요소 값 (0 ~ 255)입니다.
    private var green: Double
    /// 카테고리의 색상에서 파란색(Blue) 구성 요소 값 (0 ~ 255)입니다.
    private var blue: Double

    /// 카테고리를 적용한 다이어리를 나타내는 속성입니다.
    /// - Note: 다이어리가 삭제될 경우, 카테고리에서 해당 다이어리에 대한 참조를 무효화합니다. (nullify)
    @Relationship(deleteRule: .nullify) var diaries: [Diary] = []

    /// 카테고리의 색상을 반환하는 계산된 속성입니다.
    /// - Returns: RGB 값을 기반으로 생성된 Color 객체
    var color: Color {
        .init(r: red, g: green, b: blue)
    }

    /// 카테고리 모델의 초기화 메서드입니다.
    /// - Parameters:
    ///   - name: 카테고리의 고유 이름
    ///   - red: 색상의 빨간색(Red) 값 (0 ~ 255)
    ///   - green: 색상의 초록색(Green) 값 (0 ~ 255)
    ///   - blue: 색상의 파란색(Blue) 값 (0 ~ 255)
    init(name: String, red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0) {
        self.name = name
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    /// 카테고리 모델의 편의 초기화 메서드입니다.
    /// - Parameters:
    ///   - name: 카테고리의 고유 이름
    ///   - color: 카테고리의 색상 (Color 객체)
    /// - Note: Color 객체에서 RGB 값을 추출하여 각 구성 요소(red, green, blue)로 설정됩니다.
    convenience init(name: String, color: Color) {
        let rgb = color.rgbComponents()
        self.init(name: name, red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
}

extension Category {
    
    /// RGB 값으로 색상을 설정합니다.
    ///
    /// - Parameters:
    ///   - red: 빨간색(Red) 구성 요소 값 (0.0 ~ 255.0)
    ///   - green: 초록색(Green) 구성 요소 값 (0.0 ~ 255.0)
    ///   - blue: 파란색(Blue) 구성 요소 값 (0.0 ~ 255.0)
    /// - Note: 각 구성 요소 값은 0.0에서 255.0 사이여야 합니다.
    func setColor(red: Double, green: Double, blue: Double) {
        guard (0...255) ~= red,
              (0...255) ~= green,
              (0...255) ~= blue else {
            fatalError("RGB 값은 0.0에서 255.0 사이여야 합니다.")
        }
        self.red = red
        self.green = green
        self.blue = blue
    }
}


extension Category {

    static let mock: [Category] = [
        .init(name: "음식", color: .init(r: 255, g: 204, b: 102)),  // 밝은 오렌지
        .init(name: "운동", color: .init(r: 102, g: 204, b: 255)),  // 밝은 하늘색
        .init(name: "해외 여행", color: .init(r: 153, g: 102, b: 255)),  // 연보라색
        .init(name: "국내 여행", color: .init(r: 255, g: 153, b: 204)),  // 핑크
        .init(name: "독서", color: .init(r: 255, g: 102, b: 102)),  // 밝은 빨간색
        .init(name: "공부", color: .init(r: 102, g: 255, b: 178)),  // 밝은 초록색
        .init(name: "음악", color: .init(r: 204, g: 102, b: 255)),  // 보라색
        .init(name: "게임", color: .init(r: 255, g: 178, b: 102)),  // 밝은 주황색
        .init(name: "취미", color: .init(r: 102, g: 102, b: 255)),  // 파란색
        .init(name: "일기", color: .init(r: 153, g: 255, b: 102))   // 밝은 연두색
    ]
}
