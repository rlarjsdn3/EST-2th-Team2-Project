//
//  CircleButton.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct CircleButton: View {

    /// 시스템 아이콘 이름 (SF Symbols)
    private let systemName: String
    /// 버튼 클릭 시 실행될 동작 (클로저)
    private let action: () -> Void

    /// CircleButton 초기화 메서드
    /// - Parameters:
    ///   - systemName: SF Symbols 아이콘 이름입니다. (예: "house", "heart.fill")
    ///   - action: 버튼 클릭 시 실행될 동작을 지정하는 클로저입니다.
    init(systemName: String, action: @escaping () -> Void) {
        self.action = action
        self.systemName = systemName
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.title)
                .foregroundStyle(.label)
                .padding()
                .background(.appLightGray.opacity(0.55), in: .circle)

        }

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButton(systemName: "arrow.right") { }
}
