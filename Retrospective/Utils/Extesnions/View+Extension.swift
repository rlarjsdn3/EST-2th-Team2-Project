//
//  View+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

extension View {

    /// 지정된 스타일과 모서리 반경을 적용하여 뷰의 배경을 둥글게 처리하는 메서드입니다.
    /// - Parameters:
    ///   - style: 배경으로 사용할 스타일
    ///   - radius: 둥글게 처리할 모서리의 반경 (기본값: 24)
    /// - Returns: 지정된 스타일과 모서리 반경이 적용된 뷰를 반환합니다.
    ///
    /// - Important: 공통 radius 값은 아직 정해지지 않았습니다.
    /// 정해지는대로 기본 매개변수 값을 수정해주세요!
    func cornerRadius(_ style: some ShapeStyle, radius: CGFloat = 24) -> some View {
        background(style, in: RoundedRectangle(cornerRadius: radius))
    }
    
    /// 지정된 색상과 위치로 그림자 효과를 적용하는 메서드입니다.
    /// - Parameters:
    ///   - color: 그림자의 색상 (기본값: 검정색 33% 불투명도)
    ///   - radius: 그림자의 블러 반경 (기본값: 8)
    ///   - x: 그림자의 X축 오프셋 (기본값: 5)
    ///   - y: 그림자의 Y축 오프셋 (기본값: 5)
    /// - Returns: 지정된 색상과 위치로 그림자 효과가 적용된 뷰를 반환합니다.
    ///
    /// - Important: 공통 color 값은 아직 정해지지 않았습니다.
    /// 정해지는대로 기본 매개변수 값을 수정해주세요!
    func defaultShadow(
        _ color: Color = .black.opacity(0.33),
        radius: CGFloat = 8,
        x: CGFloat = 5,
        y: CGFloat = 5
    ) -> some View {
        shadow(color: color, radius: radius, x: x, y: y)
    }
}
