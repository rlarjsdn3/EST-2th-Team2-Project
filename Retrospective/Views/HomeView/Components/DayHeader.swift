//
//  DayHeader.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//

import SwiftUI

/// 날짜 구간을 구분하기 위한 헤더 뷰입니다.
/// 넓은 화면(iPad 등)에서는 좌우 패딩이 더 크게 적용됩니다.
///
/// - Parameters:
///   - title: 헤더에 표시할 날짜 텍스트
struct DayHeader: View {

    @Environment(\.horizontalSizeClass) var hSizeClass
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.label)
                .font(.title3)
                .fontWeight(.semibold)

            Spacer()
        }
        .padding(.bottom)
        .padding(.horizontal, hSizeClass == .regular ? 30 : 15)
    }
}
