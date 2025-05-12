//
//  View+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

extension View {

    /// <#Description#>
    /// - Parameters:
    ///   - style: <#style description#>
    ///   - radius: <#radius description#>
    /// - Returns: <#description#>
    /// - Important: 공통 radius 값은 아직 정해지지 않았습니다. 정해지는대로 기본 매개변수 값을 수정해주세요!
    func cornerRadius(_ style: some ShapeStyle, radius: CGFloat = 24) -> some View {
        background(style, in: RoundedRectangle(cornerRadius: radius))
    }
}
