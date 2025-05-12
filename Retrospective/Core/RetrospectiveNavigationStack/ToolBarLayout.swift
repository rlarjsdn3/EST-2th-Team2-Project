//
//  ToolBarLayout.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

struct ToolBarLayout: Identifiable {
    let id = UUID()
    ///
    var spacing: CGFloat
    ///
    var toolBarProvider: AnyView

    /// <#Description#>
    /// - Parameters:
    ///   - spacing: <#spacing description#>
    ///   - toolBarProvider: <#toolBarProvider description#>
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
