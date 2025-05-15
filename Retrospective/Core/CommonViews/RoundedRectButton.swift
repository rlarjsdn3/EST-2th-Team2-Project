//
//  RoundedRectButton.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

struct RoundedRectButton: View {

    /// 버튼에 표시할 텍스트 문자열입니다.
    let title: String
    /// 버튼의 배경 색상입니다.
    let color: Color
    /// 버튼 클릭 시 실행할 동작을 지정하는 클로저입니다.
    let action: () -> Void

    /// 둥근 사각형 버튼을 생성합니다.
    ///
    /// - Parameters:
    ///   - title: 버튼에 표시할 텍스트입니다.
    ///   - color: 버튼의 배경색입니다. 기본값은 회색(불투명도 55%)입니다.
    ///   - action: 버튼 클릭 시 실행할 동작을 지정하는 클로저입니다.
    init(
        title: String,
        color: Color = .appLightGray.opacity(0.55),
        action: @escaping () -> Void
    ) {
        self.title = title
        self.color = color
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.label)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .cornerRadius(color, radius: 18)
        }
    }
}

#Preview {
    RoundedRectButton(title: "확인") { }
}
