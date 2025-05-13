//
//  View+FloatingSheet.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

extension View {

    /// 지정된 조건에 따라 플로팅 시트를 화면에 표시하는 뷰 모디파이어입니다.
    /// - Parameters:
    ///   - isPresented: 시트가 표시될지 여부를 나타내는 바인딩 값입니다.
    ///   - bottomOffset: 시트가 바닥으로부터 떨어져 있는지 나타내는 값입니다.
    ///   - onDismiss: 시트가 닫힐 때 호출되는 클로저입니다.
    ///   - content: 시트에 표시할 콘텐츠를 제공하는 클로저입니다.
    /// - Returns: 플로팅 시트가 적용된 뷰를 반환합니다.
    func floatingSheet<Content>(
        isPresented: Binding<Bool>,
        bottomOffset: CGFloat = 100,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        ZStack {
            self
            FloatingSheet(
                isPresented: isPresented,
                bottomOffset: bottomOffset,
                onDismiss: onDismiss,
                content: content
            )
        }
    }
}
