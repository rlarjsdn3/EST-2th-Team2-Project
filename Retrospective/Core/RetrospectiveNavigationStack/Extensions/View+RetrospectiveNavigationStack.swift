//
//  View+RetrospectiveNavigationStack.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

extension View {

    /// 사용자 지정 네비게이션 바의 타이틀을 설정합니다.
    /// - Parameter title: 네비게이션 바에 표시될 타이틀 텍스트
    /// - Returns: 타이틀이 지정된 새로운 뷰
    func retrospectiveNavigationTitle(_ title: String) -> some View {
        self.preference(key: NavigationTitlePreferenceKey.self, value: title)
    }


    /// 사용자 지정 네비게이션 바의 좌측 툴바를 설정합니다.
    /// - Parameters:
    ///   - spacing: 툴바 아이템 간의 간격 (기본값: 10)
    ///   - content: 툴바에 표시될 뷰를 제공하는 클로저
    /// - Returns: 좌측 툴바가 지정된 새로운 뷰
    func retrospectiveLeadingToolBar(
        spacing: CGFloat = 10,
        @ViewBuilder _ content: @escaping () -> some View
    ) -> some View {
        self.preference(
            key: LeadingToolBarPreferenceKey.self,
            value: ToolBarLayout(spacing: spacing, toolBarProvider: AnyView(content()))
        )
    }

    /// 사용자 지정 네비게이션 바의 우측 툴바를 설정합니다.
    /// - Parameters:
    ///   - spacing: 툴바 아이템 간의 간격 (기본값: 10)
    ///   - content: 툴바에 표시될 뷰를 제공하는 클로저
    /// - Returns: 우측 툴바가 지정된 새로운 뷰
    func retrospectiveTrailingToolbar(
        spacing: CGFloat = 10,
        @ViewBuilder _ content: @escaping () -> some View
    ) -> some View {
        self.preference(
            key: TrailingToolBarPreferenceKey.self,
            value: ToolBarLayout(spacing: spacing, toolBarProvider: AnyView(content()))
        )
    }
    
    /// 사용자 지정 내비게이션 바 색상을 설정합니다.
    /// - Parameter color: 내비게이션 바에 적용할 색상입니다.
    /// - Returns: 지정된 내비게이션 바 색상 프리퍼런스가 적용된 뷰
    func retrospectiveNavigationBarColor(_ color: Color) -> some View {
        self.preference(key: NavigationBarColorPreferenceKey.self, value: color)
    }
}
