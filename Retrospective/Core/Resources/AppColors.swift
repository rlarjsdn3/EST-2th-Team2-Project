//
//  AppColors.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI

extension ShapeStyle where Self == Color {

    /// 앱 메인 색상, 백그라운드 색상
    static var example: Color {
        .init(
            light: Color(r: 111.0, g: 111.0, b: 111.0),
            dark:  Color(r: 222.0, g: 222.0, b: 222.0)
        )
    }
}

