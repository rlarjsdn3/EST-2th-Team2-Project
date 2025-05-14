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
 TODO: 글 등록 버튼 비활성화일 때 색을 다르게 조정하려고 했는데 적용이 안되네 ->

```
 RetrospectiveToolBarItem(.symbol("square.and.pencil")) {
 }
 .opactiy((title.isEmpty || content.isEmpty) ? 0.1 : 1.0)
 ```

 이런식으로 적용하시면 됩니다~


 혹은 색상을 변경하고 싶으시다면

 ```swift
 let config = ToolBarConfiguration(symbolTint: .red)
 RetrospectiveToolBarItem(.symbol("trash"), configuration: config) {
 }
 ```

 ToolBarConfiguration 객체를 만든 다음 ToolBarItem에 집어넣으세요~

 ⭐️ TODO: CRUD
 */

struct WritingView: View {

    /// 저장된 카테고리 목록을 가져옴

    //    var filteredCategories: [Category] {
    //
    //    }

    /// 저장된 다이어리 목록을 가져옴
    //    @Query private var diary: [Diary]

    //    @State var isCategoryOnArray: [Bool] = Array(repeating: false, count: 4)

    //    @State private var categoryName: [String] = Array(repeating: "카테고리", count: 4)
    //    @State private var categoryColor: Color = .blue

    enum FieldType: Hashable {
        case title
        case content
    }

    @FocusState var focused: FieldType?

    private let placeholder: String = "내용"



    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query var categories: [Category]

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var categoriesSelection: [Category] = []
    @State private var isEditMode: Bool = false
    ///
    let diary: Diary?


    /// WritingView를 초기화합니다.
    ///
    /// - `diary` 매개변수에 `nil`을 전달하면 '새 글 작성' 모드로 동작합니다.
    /// - 반면, `diary` 매개변수에 기존 `Diary` 객체를 전달하면 '글 편집' 모드로 동작합니다.
    ///
    /// - Parameter diary: 작성하거나 편집할 Diary 객체 (nil일 경우 새 글 작성 모드)
    init(diary: Diary?) {
        self.diary = diary
    }


    var body: some View {
        RetrospectiveNavigationStack {
            VStack(spacing: 10) {
                VStack(alignment: .trailing, spacing: 0) {
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
                            .onAppear {
                                focused = .title
                                /// 다이어리를 작성할 때 키보드가 올라온 상태에서 키보드 밖 화면을 누르면 키보드가 내려감
                                UIApplication.shared.hideKeyboard()
                            }
                            .foregroundColor(.label)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(height: 35)
                            .padding(.horizontal, 19)
                            .lineLimit(1)
                    }
                    .padding(.vertical)
                    .background {
                        UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                            .fill(Color.appSkyBlue2)
                    }

                    Divider()

                    VStack {
                        TextEditor(text: $content)
                            .customTextEditor(placeholder: placeholder, text: $content)
                    }
                    .padding(.vertical)
                    .background {
                        UnevenRoundedRectangle(bottomLeadingRadius: 20, bottomTrailingRadius: 20)
                            .fill(Color.appSkyBlue)
                    }

                }
                .padding(.horizontal, 10)
                .padding(.top, 10)

                HStack {
                    /// 카테고리 버튼
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach (categories) { category in
                                CategoryButton(category: category.name, categoryColor: category.color) {
                                    self.categoriesSelection.append(category)
                                }
                            }
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
            .cornerRadius(30)
            .padding(.horizontal, 15)
            .padding(.top, 15)
            .padding(.bottom, 65)
            /// 뒤로 가기 버튼
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) { }
            }
            .retrospectiveTrailingToolbar {
                if !isEditMode {
                    let config = ToolBarConfiguration(symbolTint: .red)
                    RetrospectiveToolBarItem(.symbol("trash"), configuration: config) {
                    }
                    .padding(.trailing, 12)
                    RetrospectiveToolBarItem(.symbol("checkmark")) {
                        isEditMode = false
                    }
                    .disabled(title.isEmpty || content.isEmpty)

                } else {
                    if let _ = diary {
                        RetrospectiveToolBarItem(.symbol("square.and.pencil")) {
                            isEditMode = true
                        }
                    } else {
                        RetrospectiveToolBarItem(.symbol("checkmark")) {
                            dismiss()
                            createDiary()
                        }
                        .disabled(title.isEmpty || content.isEmpty)
                    }
                }
            }
            .retrospectiveNavigationTitle("Our Camp Diary")
            .retrospectiveNavigationBarColor(.appLightPeach)
        }
        .background(.appLightPeach)
    }
}


// MARK: - Logics

extension WritingView {

    /// 새로운 다이어리를 생성하고 저장합니다.
    ///
    /// - 다이어리 객체를 생성하여 지정된 카테고리와 함께 저장합니다.
    /// - 저장 후 자동으로 컨텍스트가 저장됩니다.
    func createDiary() {
        let diary = Diary(
            title: title,
            contents: content,
            categories: categoriesSelection
        )
        modelContext.insert(andSave: diary)
    }

    /// 기존 다이어리를 수정하고 저장합니다.
    ///
    /// - 현재 편집 중인 다이어리(`diary`)의 제목과 내용을 수정합니다.
    /// - 수정된 내용은 자동으로 저장됩니다.
    /// - 만약 다이어리가 존재하지 않을 경우 아무 작업도 수행하지 않습니다.
    func updateDiary() {
        guard let diary else { return }
        diary.title = title
        diary.contents = content
        modelContext.save(onFailure: nil)
    }

    /// 기존 다이어리를 삭제하고 저장합니다.
    ///
    /// - 지정된 다이어리(`diary`)를 데이터베이스에서 삭제합니다.
    /// - 삭제된 후 자동으로 저장됩니다.
    /// - 만약 다이어리가 존재하지 않을 경우 아무 작업도 수행하지 않습니다.
    func deleteDiary() {
        guard let diary else { return }
        modelContext.delete(andSave: diary)
    }
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
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
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
    WritingView(diary: nil)
        .modelContainer(PersistenceManager.previewContainer)
}

#Preview {
    WritingView(diary: .mock[0])
        .modelContainer(PersistenceManager.previewContainer)
}
