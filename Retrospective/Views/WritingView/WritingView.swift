//
//  WritingView.swift
//  Retrospective
//
//  Created by 정소이 on 5/13/25.
//

//import Foundation
import SwiftUI
import SwiftData

struct WritingView: View, KeyboardReadable {

    enum FieldType: Hashable {
        case title
        case content
    }

    @FocusState var focused: FieldType?
    @Query var categories: [Category]

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) var hSizeClass

    /// 글 작성 부분 구성요소 입니다.
    /// - placeholder: text
    private let placeholder: String = "내용"
    @State private var title: String = ""
    @State private var content: String = ""

    @State private var categoriesSelection: [Category] = []
    @State private var categoryButtons: [CategoryButton] = []
    let diary: Diary?

    @State private var isEditMode: Bool = false

    @State private var showingDeleteAlert: Bool = false

    @StateObject var viewModel = ContentViewModel()

    /// WritingView를 초기화합니다.
    ///
    /// - `diary` 매개변수에 `nil`을 전달하면 '새 글 작성' 모드로 동작합니다.
    /// - 반면, `diary` 매개변수에 기존 `Diary` 객체를 전달하면 '글 편집' 모드로 동작합니다.
    ///
    /// - Parameter diary: 작성하거나 편집할 Diary 객체 (nil일 경우 새 글 작성 모드)
    init(diary: Diary?) {
        self.diary = diary
        self._title = State(initialValue: diary?.title ?? "")
        self._content = State(initialValue: diary?.contents ?? "")
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

                        /// 제목을 작성하는 곳
                        /// 1. 새 글 작성 모드일 때
                        if diary == nil {
                            TextField("제목", text: $title)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .focused($focused, equals: .title)
                                .onAppear {
                                    focused = .title
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
                        else if isEditMode == false {
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
                        else if isEditMode == true {
                            TextField("", text: $title)
                                .focused($focused, equals: .title)
                                .onAppear {
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
                                .customTextEditor(placeholder: placeholder, text: $content, isEditMode: $isEditMode)
                        }

                        /// 2. 상세 글 보기 모드일 때
                        else if isEditMode == false {
                            TextEditor(text: $content)
                                .customTextEditor(placeholder: placeholder, text: $content, isEditMode: $isEditMode)
                                .disabled(true)
                        }

                        /// 3. 글 편집 모드일 때
                        else if isEditMode == true {
                            TextEditor(text: $content)
                                .customTextEditor(placeholder: placeholder, text: $content, isEditMode: $isEditMode)
                                .disabled(false)
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
                    /// 카테고리 버튼이 뜨는 곳
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            /// 1. 새 글 작성 모드일 때
                            // TODO: 왜 안뜨니.....
                            if diary == nil {
                                ForEach (categoryButtons) { button in
                                    button
                                }
                            }

                            /// 2. 상세 글 보기 모드일 때
                            else if isEditMode == false {
                                ForEach (diary!.categories) { category in
                                    CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }
                                        .disabled(true)
                                }
                            }

                            /// 3. 글 편집 모드일 때
                            else if isEditMode == true {
                                ForEach (categoryButtons) { button in
                                    button
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)

                    if (diary == nil || isEditMode == true) {
                        NavigationLink(destination: CategoryView()) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.label)
                                .padding(.leading, 5)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
            }
            .cornerRadius(30)
            .padding(.horizontal, hSizeClass == .regular ? 30 : 15)
            .padding(.top, hSizeClass == .regular ? 30 : 15)
            .padding(.bottom, viewModel.isShowingKeyboard == true ? 0 : 70)

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
                    }
                    .padding(.trailing, 12)
                    RetrospectiveToolBarItem(.symbol("checkmark")) {
                        updateDiary()
                        isEditMode = false
                    }
                    .opacity((title.isEmpty || content.isEmpty) ? 0.1 : 1.0)
                    .disabled(title.isEmpty || content.isEmpty)

                } else {
                    if let _ = diary {
                        RetrospectiveToolBarItem(.symbol("pencil")) {
                            isEditMode = true
                            self.title = diary!.title
                            self.content = diary!.contents
                            self.categoriesSelection = diary!.categories
                        }
                    } else {
                        RetrospectiveToolBarItem(.symbol("checkmark")) {
                            dismiss()
                            createDiary()
                        }
                        .opacity((title.isEmpty || content.isEmpty) ? 0.1 : 1.0)
                        .disabled(title.isEmpty || content.isEmpty)
                    }
                }
            }
            .retrospectiveNavigationTitle(diary == nil ? "새로운 글 작성" : (isEditMode == true ? "수정하기" : "상세보기"))
            .retrospectiveNavigationBarColor(.appLightPeach)
        }
        .background(.appLightPeach)
        .onAppear {
            guard let diary else { return }
            categoriesSelection = diary.categories
            initializeCategoryButtons()
        }
        .onChange(of: isEditMode) { _, _ in
            if isEditMode {
                initializeCategoryButtons()
            }
        }
        .alert("삭제 확인", isPresented: $showingDeleteAlert) {
            Button("삭제", role: .destructive) {
                dismiss()
                deleteDiary()
            }

            Button("취소", role: .cancel) { }
        } message: {
            Text("삭제된 다이어리는 되돌릴 수 없으며, 영구적으로 사라집니다.")
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
                            self.categoriesSelection.remove(at: firstIndex)
                        } else {
                            self.categoriesSelection.append(category)
                        }

                        withAnimation {
                            initializeCategoryButtons()
                        }
                    }
                )
            }
            .sorted { e1, e2 in
                let selected1 = categoriesSelection.contains(where: { $0.name == e1.category })
                let selected2 = categoriesSelection.contains(where: { $0.name == e2.category })
                return selected1 && !selected2
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
        diary.title = title
        diary.contents = content
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

#Preview {
    WritingView(diary: nil)
        .modelContainer(PersistenceManager.previewContainer)
}

#Preview {
    WritingView(diary: .mock[0])
        .modelContainer(PersistenceManager.previewContainer)
}
