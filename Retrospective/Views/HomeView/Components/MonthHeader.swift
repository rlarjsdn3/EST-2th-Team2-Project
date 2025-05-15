//
//  MonthHeader.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//
import SwiftUI

/// 월 단위 구간을 표시하는 헤더 뷰입니다.
/// 넓은 화면(iPad 등)에서는 좌우 패딩이 더 넓게 적용됩니다.
///
/// - Parameters:
///   - title: 헤더에 표시할 월 텍스트 (예: `"2024.05"`)
struct MonthHeader: View {
    @Environment(\.horizontalSizeClass) var hSizeClass

    let title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.label)
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()
        }
        .padding(.bottom, 8)
        .padding(.horizontal, hSizeClass == .regular ? 30 : 15)
        .frame(maxWidth: .infinity)
        .background(Color.appLightPeach)

    }
}
