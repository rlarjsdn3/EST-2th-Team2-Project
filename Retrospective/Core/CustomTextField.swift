//
//  TextField.swift
//  Retrospective
//
//  Created by juks86 on 5/13/25.
//

import SwiftUI
///TextField 커스텀 하실때 쓰시면됩니다. 아래는 사용 예시 입니다. 스트링 타입의 상태 변수 하나 만들어주시고 placeholder라는 파라미터에 원하시는 값 입력하시면 됩니다.
//		@State private var nameInput: String = ""
//
//		var body: some View {
//      CustomTextField(placeholder: "이름을 입력해주세요", text: $nameInput)
//  }

struct CustomTextField: View {
    var Placeholder: String
    @Binding var text: String


    var body: some View {
        HStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField(Placeholder, text: $text)
            }
            .padding()
            .frame(width: .infinity, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.appSkyBlue.opacity(0.5)) // 내부 배경색

            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.appLightGray.opacity(0.5), lineWidth: 1) // 테두리 색상 및 두께
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
                CustomTextField(Placeholder: "이름을 입력해주세요", text: $nameInput)
                    .modelContainer(PersistenceManager.previewContainer)
            }
        }

    return PreviewWrapper()
}
