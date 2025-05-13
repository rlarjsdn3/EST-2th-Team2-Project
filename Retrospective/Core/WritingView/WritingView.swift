//
//  WritingView.swift
//  Retrospective
//
//  Created by 정소이 on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

/*
 TODO: 글 등록 버튼 비활성화일 때 색을 다르게 조정하려고 했는데 적용이 안되네
 ⭐️ TODO: CRUD
 */

struct WritingView: View {
    @State private var title: String = ""
    @State private var content: String = ""

    @Environment(\.modelContext) var modelContext

    /// 저장된 카테고리 목록을 가져옴
    @Query var allCategories: [Category]

    //    var filteredCategories: [Category] {
    //
    //    }

    /// 저장된 다이어리 목록을 가져옴
    @Query private var diary: [Diary]

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
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                HStack {
                    /// 카테고리 버튼
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            /// ⭐️ 저장된 카테고리 목록을 보여줌
//                            ForEach (allCategories) {category in
//                                CategoryButton(isCategoryOn: .constant(true), category: category.name, categoryColor: category.color)
//                            }
                            // 카테고리가 어떻게 나오나 보려고 그냥 임의값 넣어두고 표시함
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
                .cornerRadius(30)
                .padding(.horizontal, 15)
                .padding(.top, 15)
                .padding(.bottom, 65)
                /// 뒤로 가기 버튼
                .retrospectiveLeadingToolBar {
                    RetrospectiveToolBarItem(.symbol("chevron.left")) {
                        dismiss() // 안먹힘
                    }
                }
                /// ⭐️ 다이어리 추가 버튼
                .retrospectiveTrailingToolbar {
                    RetrospectiveToolBarItem(.symbol("checkmark")) {
                        //                        addDiary()
                        dismiss() // 이것도 안먹힘
                    }
                    /// 제목과 내용 둘 중에 하나라도 비어있으면 등록 버튼 비활성화
                    .disabled(title.isEmpty || content.isEmpty)
                }
                .retrospectiveNavigationTitle("Our Camp Diary")
//                .retrospectiveNavigationBarColor(.appLightPeach)
            }
            .background(.appLightPeach)
        }

        /// ⭐️ 다이어리 추가 메서드
        /// 선택한 카테고리만 넘겨주어야 하는데, categories 쪽을 이렇게 하는 건지 모르겠다.
        //    private func addDiary() {
        //        let newDiary = Diary(title: title, contents: content, categories: categories)
        //        modelContext.insert(newDiary)
        //    }
}

/// 텍스트 에디터 커스텀 스타일
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
