//
//  AppColors.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI

extension ShapeStyle where Self == Color {

    /// 주요 글자색
    ///
    /// * 라이트 모드: 검정색
    /// * 다크 모드: 흰색
    static var label: Color {
        .init(UIColor.label)
    }
}

