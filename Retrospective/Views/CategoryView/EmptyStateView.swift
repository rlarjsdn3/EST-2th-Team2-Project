//
//  EmptyStateView.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct EmptyStateView: View {
    var systemName: String
    var title: String
    var description: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            VStack(spacing: 8) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(description)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        systemName: "swiftdata",
        title: "통계 데이터가 없습니다.",
        description: "일기를 작성하여 통계 데이터를 확인해보세요."
    )
}
