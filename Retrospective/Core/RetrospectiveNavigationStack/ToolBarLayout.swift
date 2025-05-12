//
//  ToolBarLayout.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

/// 사용자 지정 툴바 레이아웃을 정의하는 구조체입니다.
/// - Note: 툴바 아이템의 간격과 제공할 뷰를 설정할 수 있습니다.
struct ToolBarLayout: Identifiable {
    let id = UUID()
    /// 툴바 아이템 간의 간격
    var spacing: CGFloat
    /// 툴바에 표시될 뷰를 래핑한 AnyView
    var toolBarProvider: AnyView

    /// ToolBarLayout을 초기화합니다.
    /// - Parameters:
    ///   - spacing: 툴바 아이템 간의 간격
    ///   - toolBarProvider: 툴바에 표시될 뷰를 제공하는 클로저
    init(spacing: CGFloat, toolBarProvider: @escaping @autoclosure () -> AnyView) {
        self.spacing = spacing
        self.toolBarProvider = toolBarProvider()
    }
}

extension ToolBarLayout: Equatable {
    static func == (lhs: ToolBarLayout, rhs: ToolBarLayout) -> Bool {
        lhs.id == rhs.id
    }
}
