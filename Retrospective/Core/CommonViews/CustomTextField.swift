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
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.label)
                }
            }
            .padding()
            .frame(height: 45)
            .frame(maxWidth: .infinity)
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
    @Previewable @State var input: String = ""
    CustomTextField(placeholder: "Placeholder", text: $input)
}
