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


extension View {

    /// 지정된 PreferenceKey의 값이 변경될 때 메인 스레드에서 동기적으로 동작하는 클로저를 실행합니다.
    /// - Parameters:
    ///   - key: PreferenceKey 타입으로, 변경 사항을 감지할 키 타입
    ///   - action: Preference 값 변경 시 실행할 클로저. MainActor에서 동기적으로 실행됩니다.
    /// - Returns: Preference 변경 감지 및 MainActor에서 클로저를 실행하는 새로운 뷰
    func onPreferenceChangeMainActor<K>(
        _ key: K.Type = K.self,
        perform action: @escaping (K.Value) -> Void
    ) -> some View where K: PreferenceKey, K.Value: Equatable {
        self.onPreferenceChange(key) { value in
            Task { @MainActor in
                action(value)
            }
        }
    }
}
