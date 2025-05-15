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
 글 등록 버튼 비활성화일 때 색을 다르게 조정하려고 했는데 적용이 안되네 ->

 ```
 RetrospectiveToolBarItem(.symbol("square.and.pencil")) {
 }
 .opactiy((title.isEmpty || content.isEmpty) ? 0.1 : 1.0)
 ```

 이런식으로 적용하시면 됩니다~ > ⭐️ TODO: 요렇게 했는데 안돼요ㅠ


 혹은 색상을 변경하고 싶으시다면

 ```swift
 let config = ToolBarConfiguration(symbolTint: .red)
 RetrospectiveToolBarItem(.symbol("trash"), configuration: config) {
 }
 ```

 ToolBarConfiguration 객체를 만든 다음 ToolBarItem에 집어넣으세요~
 */

struct WritingView: View {
    private let placeholder: String = "내용"

    enum FieldType: Hashable {
        case title
        case content
    }

    @FocusState var focused: FieldType?

    @State private var textfieldTitle: String = ""
    @State private var textfieldContent: String = ""

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query var categories: [Category]

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var categoriesSelection: [Category] = []
    @State private var isEditMode: Bool = false
    @State private var showingDeleteAlert: Bool = false

    let diary: Diary?

    @State private var categoryButtons: [CategoryButton] = []
    @State private var sortedCategoryButtons: [CategoryButton] = []

    /// WritingView를 초기화합니다.
    ///
    /// - `diary` 매개변수에 `nil`을 전달하면 '새 글 작성' 모드로 동작합니다.
    /// - 반면, `diary` 매개변수에 기존 `Diary` 객체를 전달하면 '글 편집' 모드로 동작합니다.
    ///
    /// - Parameter diary: 작성하거나 편집할 Diary 객체 (nil일 경우 새 글 작성 모드)
    init(diary: Diary?) {
        self.diary = diary
    }

    var sortCategoryButtons: [CategoryButton] {
        let selectedButtons = categoryButtons.filter { button in
            categoriesSelection.contains(where: { $0.name == button.category })
        }

        let unselectedButtons = categoryButtons.filter { button in
            !categoriesSelection.contains(where: { $0.name == button.category })
        }

        return selectedButtons + unselectedButtons
    }

    // ⭐️ TODO: .contentMargins을 추가하려고 했는데, 스크롤뷰로 감싸면 높이가 짜부됨
    var body: some View {
        RetrospectiveNavigationStack {
//            NavigationStack {
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

                            /// 제목을 작성하는 곳
                            /// 1. 새 글 작성 모드일 때
                            if diary == nil {
                                TextField("제목", text: $title)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .focused($focused, equals: .title)
                                    .onAppear {
                                        focused = .title
                                        /// 다이어리를 작성할 때 키보드가 올라온 상태에서 키보드 밖 화면을 누르면 키보드가 내려감
                                        UIApplication.shared.hideKeyboard()
                                    }
                                    .onSubmit {
                                        focused = .content
                                    }
                                    .onChange(of: title) { newValue in
                                        if newValue.count > 15 {
                                            title = String(newValue.prefix(15))
                                        }
                                    }
                                    .foregroundColor(.label)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .frame(height: 35)
                                    .padding(.horizontal, 19)
                                    .lineLimit(1)
                            }

                            /// 2. 상세 글 보기 모드일 때
                            else if (diary != nil && isEditMode == false) {
                                HStack {
                                    Text(diary!.title)
                                        .foregroundColor(.label)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .frame(height: 35)
                                        .padding(.horizontal, 19)

                                    Spacer()
                                }
                            }

                            /// 3. 글 편집 모드일 때
                            else if (diary != nil && isEditMode == true) {
                                TextField("", text: $textfieldTitle)
                                    .focused($focused, equals: .title)
                                    .onAppear {
                                        UIApplication.shared.hideKeyboard()
                                    }
                                    .onSubmit {
                                        focused = .content
                                    }
                                    .onChange(of: textfieldTitle) { newValue in
                                        if newValue.count > 15 {
                                            textfieldTitle = String(newValue.prefix(15))
                                        }
                                    }
                                    .foregroundColor(.label)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .frame(height: 35)
                                    .padding(.horizontal, 19)
                                    .lineLimit(1)
                            }

                            else {
                                EmptyView()
                            }
                        }
                        .padding(.vertical)
                        .background {
                            UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                                .fill(Color.appSkyBlue2)
                        }

                        Divider()

                        /// 내용을 작성하는 곳
                        VStack {
                            /// 1. 새 글 작성 모드일 때
                            if diary == nil {
                                TextEditor(text: $content)
                                    .customTextEditor(placeholder: placeholder, text: $content)
                            }

                            /// 2. 상세 글 보기 모드일 때
                            else if (diary != nil && isEditMode == false) {
                                VStack {
                                    Text(diary!.contents)
                                        .lineSpacing(10)
                                        .foregroundColor(.label.opacity(0.9))
                                        .padding(.horizontal, 10)
                                        .padding(.top, 10)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                }

                                HStack {
                                    Spacer()

                                    Text("\(diary!.contents.count) / 300")
                                        .font(.footnote)
                                        .foregroundColor(.secondary.opacity(0.7))
                                        .padding(.trailing, 15)
                                }
                            }

                            /// 3. 글 편집 모드일 때
                            else if (diary != nil && isEditMode == true) {
                                TextEditor(text: $textfieldContent)
                                    .customTextEditor(placeholder: placeholder, text: $textfieldContent)
                            }

                            else {
                                EmptyView()
                            }
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
                                /// 새 글 작성 모드일 때
                                if diary == nil {
                                    ForEach (categoryButtons) { categoryButton in
                                        categoryButton
                                    }
                                }

                                /// 상세 글 보기 모드일 때
                                else if (diary != nil && isEditMode == false) {
                                    if categories.isEmpty {
                                        EmptyView()
                                    } else {
                                        ForEach (diary!.categories) { category in
                                            CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }
                                        }
                                    }
                                }

                                /// 글 편집 모드일 때
                                // ⭐️ TODO: 선택된&선택되지않은 카테고리 모두 표시
                                else if (diary != nil && isEditMode == true) {
                                    if categories.isEmpty {
                                        EmptyView()
                                    } else {
                                        ForEach (categoryButtons) { button in
                                            button
                                        }
                                    }
                                }
                            }
                            //.presentationDetents([.height(150), .fraction(0.8)])
                        }
                        .scrollIndicators(.hidden)

                        NavigationLink(destination: CategoryView()) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.label)
                                .padding(.leading, 5)
                        }
                        .disabled(diary != nil && isEditMode == false)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                }
                .cornerRadius(30)
                .padding(.horizontal, 15)
                .padding(.top, 15)
                // ⭐️ TODO: dismiss가 왜 안될까ㅠ
                .retrospectiveLeadingToolBar {
                    RetrospectiveToolBarItem(.symbol("chevron.left")) {
                        dismiss()
                    }
                }
                .retrospectiveTrailingToolbar {
                    if isEditMode {
                        let config = ToolBarConfiguration(symbolTint: .red)
                        RetrospectiveToolBarItem(.symbol("trash"), configuration: config) {
                            showingDeleteAlert = true
                            dismiss()
                            deleteDiary()
                        }
                        .padding(.trailing, 12)
                        RetrospectiveToolBarItem(.symbol("checkmark")) {
                            dismiss()
                            updateDiary()
                            isEditMode = false
                        }
                        .opacity((textfieldTitle.isEmpty || textfieldContent.isEmpty) ? 0.1 : 1.0)
                        .disabled(textfieldTitle.isEmpty || textfieldContent.isEmpty)

                    } else {
                        if let _ = diary {
                            RetrospectiveToolBarItem(.symbol("pencil")) {
                                isEditMode = true
                                self.textfieldTitle = diary!.title
                                self.textfieldContent = diary!.contents
                                self.categoriesSelection = diary!.categories
                            }
                        } else {
                            RetrospectiveToolBarItem(.symbol("checkmark")) {
                                dismiss()
                                createDiary()
                            }
                            .disabled(textfieldTitle.isEmpty || textfieldContent.isEmpty)
                        }
                    }
                }
                .onChange(of: isEditMode) { _, _ in
                    print("isEditmode", isEditMode)
                    categoriesSelection.forEach { c in
                        print(c.name)
                    }

                    if isEditMode {
                        initializeCategoryButtons()
                    }
                }
                .retrospectiveNavigationTitle(diary == nil ? "새로운 글 작성" : "")
                .retrospectiveNavigationBarColor(.appLightPeach)
//            }
        }
        .background(.appLightPeach)
        .onAppear {
            if let diary = diary {
                self.categoriesSelection = diary.categories
                print("셀력샨 추가됨!")
            }

            categoryButtons = categories
                    .map { category in
                        let isSelected = categoriesSelection.contains(where: { $0.name == category.name })
                        print("선택 상태:", isSelected)

                        return CategoryButton(
                            category: category.name,
                            categoryColor: category.color,
                            initialCategoryHighlightStatus: isSelected,
                            action: {
                                if let firstIndex = categoriesSelection.firstIndex(where: { $0.name == category.name }) {
                                    print("제거됨", firstIndex)
                                    self.categoriesSelection.remove(at: firstIndex)
                                    print(self.categoriesSelection)
                                } else {
                                    print("추가됨", category)
                                    self.categoriesSelection.append(category)
                                }
                            }
                        )
                    }
                    .sorted { e1, e2 in
                        categoriesSelection.contains(where: { $0.name == e1.category })
                        && !categoriesSelection.contains(where: { $0.name == e2.category })
                    }
        }
        .alert("이 글을 삭제하시겠습니까?", isPresented: $showingDeleteAlert) {
            Button("예", role: .destructive) {
                deleteDiary()
            }
            Button("아니오", role: .cancel) { }
        }
    }
}


// MARK: - Logics

extension WritingView {

    private func initializeCategoryButtons() {
        categoryButtons = categories
            .map { category in
                let isSelected = categoriesSelection.contains(where: { $0.name == category.name })

                return CategoryButton(
                    category: category.name,
                    categoryColor: category.color,
                    initialCategoryHighlightStatus: isSelected,
                    action: {
                        if let firstIndex = categoriesSelection.firstIndex(where: { $0.name == category.name }) {
                            print("제거됨:", firstIndex)
                            self.categoriesSelection.remove(at: firstIndex)
                        } else {
                            print("추가됨:", category.name)
                            self.categoriesSelection.append(category)
                        }
                        // 갱신된 상태를 반영
                        withAnimation {
                            initializeCategoryButtons()
                        }
                    }
                )
            }
            .sorted { e1, e2 in
                categoriesSelection.contains(where: { $0.name == e1.category })
                && !categoriesSelection.contains(where: { $0.name == e2.category })
            }
    }
}

extension WritingView {

    /// 새로운 다이어리를 생성하고 저장합니다.
    ///
    /// - 다이어리 객체를 생성하여 지정된 카테고리와 함께 저장합니다.
    /// - 저장 후 자동으로 컨텍스트가 저장됩니다.
    private func createDiary() {
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
    private func updateDiary() {
        guard let diary else { return }
        diary.title = textfieldTitle
        diary.contents = textfieldContent
        diary.categories = categoriesSelection
        modelContext.save(onFailure: nil)
    }

    /// 기존 다이어리를 삭제하고 저장합니다.
    ///
    /// - 지정된 다이어리(`diary`)를 데이터베이스에서 삭제합니다.
    /// - 삭제된 후 자동으로 저장됩니다.
    /// - 만약 다이어리가 존재하지 않을 경우 아무 작업도 수행하지 않습니다.
    private func deleteDiary() {
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
                        .padding(.vertical, 15)
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
