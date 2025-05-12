//
//  View+FloatingSheet.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

extension View {

    func floatingSheet<Content>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        ZStack {
            self
            FloatingSheet(
                isPresented: isPresented,
                onDismiss: onDismiss,
                content: content
            )
        }
    }

}
