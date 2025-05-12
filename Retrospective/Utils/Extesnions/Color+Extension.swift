//
//  Color+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

extension Color {

    /// RGB 값을 사용하여 Color 인스턴스를 생성합니다.
    /// - Parameters:
    ///   - r: 빨간색(Red) 값 (0 ~ 255)
    ///   - g: 초록색(Green) 값 (0 ~ 255)
    ///   - b: 파란색(Blue) 값 (0 ~ 255)
    init(r: Double, g: Double, b: Double) {
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0
        )
    }

    /// 라이트 모드와 다크 모드에서 다른 색상을 사용할 수 있는 Color 인스턴스를 생성합니다.
    /// - Parameters:
    ///   - light: 라이트 모드에서 사용할 Color
    ///   - dark: 다크 모드에서 사용할 Color
    init(light: Color, dark: Color) {
        self.init(uiColor:
                    UIColor(
                        light: UIColor(light),
                        dark: UIColor(dark)
                    )
        )
    }
}
