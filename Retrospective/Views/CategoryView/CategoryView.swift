//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by juks86 on 5/13/25.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Category.name) private var categories: [Category]

    @State private var newCategoryName: String = ""
    @State private var showingDuplicateAlert: Bool = false
    @State private var categoryToDelete: Category? = nil
    @State private var showingDeleteAlert: Bool = false
    @State private var textLength: String = ""
    @State private var showingMinimumCategoryAlert = false

    var body: some View {
        RetrospectiveNavigationStack {
            VStack(spacing: -20) {
                HStack {
                    CustomTextField(placeholder: "카테고리 이름을 작성해주세요.", text: $newCategoryName)
                        .onChange(of: newCategoryName) { newValue in
                            if newValue.count > 15 {
                                newCategoryName = String(newValue.prefix(15))
                            }
                        }
                        //.padding(.leading, -20)
                        .autocapitalization(.none)

                    Button(action: {
                        addCategory()
                    }) {
                        Image(systemName: "plus")
                            .font(.title3)
                            .font(.headline)
                    }
                    .disabled(newCategoryName.isEmpty)
                    .foregroundStyle(.label)
                }
                .padding(.vertical, 0)
                .padding(.trailing, 25)


                ScrollView {
                    LazyVStack {
                        ForEach(categories) { category in

                            HStack {
                                Circle()
                                    .fill(category.color)
                                    .frame(width: 15, height: 15)
                                Text(category.name)
                                    .font(.headline)
                                Spacer()

                                NavigationLink(destination: EditCategoryView(category: category)) {
                                    Image(systemName: "pencil")
                                        .font(.title3)
                                        .foregroundStyle(.label)
                                        .padding(.horizontal, 20)
                                }

                                Button {
                                    if categories.count <= 1 {
                                        showingMinimumCategoryAlert = true
                                    } else {
                                        categoryToDelete = category
                                        showingDeleteAlert = true
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .font(.title3)
                                }
                                .foregroundStyle(.red)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        }
                        Spacer().frame(height: 50)
                    }

                }
                .padding()
                .scrollIndicators(.hidden)

                .contentMargins(.bottom, 80, for: .scrollIndicators)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

            .background(Color.appLightPeach)
            //.ignoresSafeArea(.all)
            .alert("중복된 이름입니다.", isPresented: $showingDuplicateAlert) {
                Button("확인", role: .cancel) { }
            }
            .alert("삭제 확인", isPresented: $showingDeleteAlert) {
                Button("삭제", role: .destructive) {
                    if let category = categoryToDelete {
                        for diary in category.diaries {
                            diary.categories.removeAll { $0 == category }
                        }
                        context.delete(category)
                        categoryToDelete = nil
                    }

                }
                Button("취소", role: .cancel) {
                    categoryToDelete = nil
                }
            } message: {
                Text("삭제된 카테고리는 되돌릴 수 없으며, 영구적으로 사라집니다.")
            }
            .alert("최소 한개 이상의 카테고리가 필요합니다.", isPresented: $showingMinimumCategoryAlert) {
                Button("확인", role: .cancel) { }
            }
            .retrospectiveNavigationTitle("카테고리 관리")
            .retrospectiveNavigationBarColor(.appLightPeach)
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) {
                    dismiss()
                }
            }
        }


    }

    private func addCategory() {
        guard !categories.contains(where: { $0.name == newCategoryName }) else {
            showingDuplicateAlert = true
            return
        }

        let randomColor = Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )

        let newCategory = Category(name: newCategoryName, color: randomColor)
        context.insert(newCategory)

        newCategoryName = ""
    }

    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            for diary in category.diaries {
                diary.categories.removeAll { $0 == category }
            }
            context.delete(category)
        }
    }
}

#Preview {
    CategoryView()
        .modelContainer(PersistenceManager.previewContainer)
}
