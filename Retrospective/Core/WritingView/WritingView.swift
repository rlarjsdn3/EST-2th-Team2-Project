//
//  WritingView.swift
//  Retrospective
//
//  Created by 정소이 on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

/*  TODO: navigationbar 뒤로가기, 새 글 등록하기 버튼 기능 추가
 TODO: 제목 작성하고 엔터 누르면 내용으로 커서가 옮겨져야 하는데 안됨 (왜 되다가 안되냐)
 TODO: 글 등록 버튼 비활성화일 때 색 다르게 조정하려고 했는데 적용이 안되네
 ⭐️ TODO: 4. CRUD
 */

struct WritingView: View {
    @State private var title: String = ""
    @State private var content: String = ""

    @Environment(\.modelContext) var modelContext

    /// 저장된 카테고리 목록을 이름순으로 가져옴
    @Query(sort: \Category.name) private var categories: [Category]

    @State var isCategoryOnArray: [Bool] = Array(repeating: false, count: 4)

    @State private var categoryName: [String] = Array(repeating: "카테고리", count: 4)
    @State private var categoryColor: Color = .blue

    enum FieldType: Hashable {
        case title
        case content
    }

    @FocusState var focused: FieldType?

    private let placeholder: String = "내용"

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        RetrospectiveNavigationStack {
            VStack(spacing: 10) {
                VStack {
                    /// 현재 날짜 출력
                    HStack {
                        Text(Date.now.formatted(.dateTime.year().month().day()))
                            .foregroundColor(.secondary)
                            .padding(.leading, 19)

                        Spacer()
                    }

                    TextField("제목", text: $title)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focused, equals: .title)
//                        .submitLabel(.next)
                        .onAppear {
                            focused = .title
                            /// 다이어리를 작성할 때 키보드가 올라온 상태에서 키보드 밖 화면을 누르면 키보드가 내려감
                            UIApplication.shared.hideKeyboard()
                        }
//                        .onSubmit {
//                            focused = .content
//                        }
                        .foregroundColor(.label)
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(height: 35)
                        .padding(.horizontal, 19)

                    Divider()
                        .background(.secondary.opacity(0.33))
                        .padding(.horizontal, 15)

                    TextEditor(text: $content)
                        .customTextEditor(placeholder: placeholder, text: $content)
//                        .focused($focused, equals: .content)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                HStack {
                    /// 카테고리 버튼
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            CategoryButton(isCategoryOn: $isCategoryOnArray[1], category: "카테고리", categoryColor: .green)
                            CategoryButton(isCategoryOn: $isCategoryOnArray[2], category: "카테고리", categoryColor: .red)
                            CategoryButton(isCategoryOn: $isCategoryOnArray[3], category: "카테고리", categoryColor: .yellow)
                        }
                        .presentationDetents([.height(150), .fraction(0.8)])
                    }
                    .scrollIndicators(.hidden)

                    // TODO: 버튼 클릭 시 filter 선택 뷰 FloatingSheet present
                    Button {

                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.label)
                            .padding(.leading, 5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
            }
            .background(.appSkyBlue)
            //.frame(width: 300)
            .cornerRadius(30)
            .padding(.horizontal, 15)
            .padding(.top, 15)
            .padding(.bottom, 65)
            /// 뒤로 가기 버튼
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) {
                    dismiss()
                }
            }
            /// 새 글 등록하기 버튼
            .retrospectiveTrailingToolbar {
                RetrospectiveToolBarItem(.symbol("checkmark")) {
                    // ⭐️ TODO: categories 부분 수정하기
                    // 근데 이렇게 데이터를 삽입 하는 게 맞나..?
//                    let diary = Diary(title: title, contents: content, categories: [.mock[0]])
//                    modelContext.insert(diary)
                }
                /// 제목과 내용 둘 중에 하나라도 비어있으면 등록 버튼 비활성화
                    .disabled(title.isEmpty || content.isEmpty)
            }
            .retrospectiveNavigationTitle("Our Camp Diary")
//            .retrospectiveNavigationBarColor(.appLightPeach)
        }
        .background(.appLightPeach)
    }
}

struct CustomTextEditorStyle: ViewModifier {
    let placeholder: String

    @Binding var text: String

    func body(content: Content) -> some View {
        content
            .lineSpacing(10)
            .foregroundColor(.label.opacity(0.9))
            .padding(.horizontal, 15)
            .background(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding(22)
                        .foregroundColor(.secondary.opacity(0.7))
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .scrollContentBackground(.hidden)

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

extension TextEditor {
    func customTextEditor(placeholder: String, text: Binding<String>) -> some View {
        self.modifier(CustomTextEditorStyle(placeholder: placeholder, text: text))
    }
}

#Preview {
    WritingView()
}

