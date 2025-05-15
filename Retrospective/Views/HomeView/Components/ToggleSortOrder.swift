//
//  ToggleSortOrder.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

struct ToggleSortOrder: View {

    /// 현재 정렬 순서를 나타내는 상태 변수입니다.
    /// - true: 최신순 (내림차순)
    /// - false: 과거순 (오름차순)
    @State var isDescending: Bool = true

    /// 정렬 순서가 변경될 때 실행할 클로저입니다.
    /// - Parameter isDescending: 현재 정렬 상태 (true: 최신순, false: 과거순)
    var action: (Bool) -> Void

    /// ToggleSortOrder 뷰를 초기화합니다.
    /// - Parameter action: 정렬 순서 변경 시 실행할 클로저
    init(action: @escaping (Bool) -> Void) {
        self.action = action
    }

    var body: some View {
        Button {
            isDescending.toggle()
            action(isDescending)
        } label: {
            HStack(spacing: 0) {
                Text(isDescending ? "최신순 " : "과거순 ")
                Image(systemName: "arrow.down")
                    .rotationEffect(.degrees(isDescending ? 0 : 180))
                    .animation(.bouncy, value: isDescending)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .fontWeight(.medium)
        }
        .foregroundStyle(.label)
        .contentTransition(.identity)
    }
}

#Preview {
    @Previewable @State var isDescending = false
    ToggleSortOrder { isDescending in
        print("isDescending", isDescending)
    }
}
