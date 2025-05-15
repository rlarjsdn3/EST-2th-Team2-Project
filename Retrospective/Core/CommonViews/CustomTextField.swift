//
//  TextField.swift
//  Retrospective
//
//  Created by juks86 on 5/13/25.
//

import SwiftUI

struct CustomTextField: View {

    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField(placeholder, text: $text)
            }
            .padding()
            .frame(width: .infinity, height: 45)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.appLightGray.opacity(0.33)) // 내부 배경색

            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.appLightGray.opacity(0.33), lineWidth: 1) // 테두리 색상 및 두께
            )
            .padding()
        }
    }
}
#Preview {
    /// 사용 예시
    struct PreviewWrapper: View {
            @State private var nameInput: String = ""

            var body: some View {
                CustomTextField(placeholder: "이름을 입력해주세요", text: $nameInput)
                    .modelContainer(PersistenceManager.previewContainer)
            }
        }

    return PreviewWrapper()
}
