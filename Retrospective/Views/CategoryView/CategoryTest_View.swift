//
//  Test2_View.swift
//  Retrospective
//
//  Created by juks86 on 5/12/25.
//

import SwiftUI
import SwiftData

/// 카테고리 뷰 만드는 중입니다. 변경 및 삭제 하지 말아 주세요~
struct Test2_View: View {
    /// SwiftData 모델 컨텍스트
    @Environment(\.modelContext) private var context

    //  저장된 Category 목록을 가져옴 (이름순 정렬)
    @Query(sort: \Category.name) private var categories: [Category] //기본 카테고리 항목으로 설정

    @State private var newCategoryName: String = ""
   // @State private var newCategoryColor: Bool = false
    @State private var showingDuplicateAlert: Bool = false
    @State private var categoryToDelete: Category? = nil
    @State private var showingDeleteAlert: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: -20) {
                /// 새 카테고리 입력 필드
                HStack{
                    CustomTextField(placeholder: "카테고리 이름을 작성해주세요.", text: $newCategoryName)

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
                .padding(.horizontal, 10)
                /// 카테고리 리스트

                ScrollView{
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
                                    Image(systemName: "square.and.pencil")
                                        .font(.title3)
                                        .foregroundStyle(.label)
                                        .padding(.horizontal,20)
                                }

                                Button {
                                    categoryToDelete = category
                                    showingDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash")
                                        .font(.title3)
                                }
                                .foregroundStyle(.label)

                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .leading)
                            .padding()

                        }


                    }

                }
                .padding()
            }
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .leading)
        .background(Color.appLightPeach)
        .ignoresSafeArea(.all)
        .alert("중복된 이름입니다.", isPresented: $showingDuplicateAlert) {
            Button("확인", role: .cancel) { }
        }
        .alert("이 카테고리를 삭제하시겠습니까?", isPresented: $showingDeleteAlert) {
                    Button("예", role: .destructive) {
                        if let category = categoryToDelete {
                            context.delete(category)
                            categoryToDelete = nil
                        }
                    }
                    Button("아니오", role: .cancel) {
                        categoryToDelete = nil
                    }
                }
            }


    ///  카테고리 추가 메서드
    private func addCategory() {

        guard !categories.contains(where: { $0.name == newCategoryName }) else {//중복된 값 작성시 경고창 표시
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

    ///  카테고리 삭제 메서드
    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            context.delete(categories[index])
        }
    }

}

#Preview {
    Test2_View()
        .modelContainer(PersistenceManager.previewContainer)
}
