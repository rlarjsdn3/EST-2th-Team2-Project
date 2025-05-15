//
//  CustomTextEditorStyle.swift
//  Retrospective
//
//  Created by 김건우 on 5/15/25.
//

import SwiftUI

struct CustomTextEditorStyle: ViewModifier {

    let placeholder: String
    @Binding var text: String
    @Binding var isEditMode: Bool

    func body(content: Content) -> some View {
        content
            .lineSpacing(10)
            .foregroundColor(.label.opacity(0.9))
            .padding(.horizontal, 15)
            .background(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .foregroundColor(.secondary.opacity(0.7))
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .scrollContentBackground(.hidden)

        if isEditMode {
            HStack {
                Spacer()

                Text("\(text.count) / 300")
                    .font(.footnote)
                    .foregroundColor(.secondary.opacity(0.7))
                    .padding(.trailing, 15)
                    .onChange(of: text) { newValue in
                        if newValue.count > 300 {
                            text = String(newValue.prefix(300))
                        }
                    }
            }
            .frame(minHeight: 30)
            .padding(.bottom, 5)
        }
    }
}

extension TextEditor {

    /// 텍스트 에디터에 사용자 지정 스타일을 적용합니다.
    ///
    /// - Parameters:
    ///   - placeholder: 텍스트가 비어 있을 때 표시할 플레이스홀더 문자열입니다.
    ///   - text: 편집할 텍스트의 바인딩 변수입니다.
    ///   - isEditMode: 편집 모드 활성화 여부를 나타내는 바인딩 변수입니다.
    /// - Returns: 사용자 지정 스타일이 적용된 텍스트 에디터 뷰입니다.
    func customTextEditor(placeholder: String, text: Binding<String>, isEditMode: Binding<Bool>) -> some View {
        self.modifier(CustomTextEditorStyle(placeholder: placeholder, text: text, isEditMode: isEditMode))
    }
}
