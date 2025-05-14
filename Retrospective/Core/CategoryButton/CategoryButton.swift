//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by 정소이 on 5/12/25.
//

import SwiftUI

struct CategoryButton: View {

    @State private var isCategoryOn: Bool = false

    /// 
    var isOn: Bool {
        self.isCategoryOn
    }

    /// 카테고리 이름 (버튼 라벨)
    let category: String

    /// 카테고리 강조 색상 (선택된 상태에서 표시될 색상)
    let categoryColor: Color

    /// 항상 카테고리 강조 색상을 표시할지 여부
    /// - true: `isCategoryOn` 상태와 관계없이 강조 색상 표시
    /// - false: `isCategoryOn`이 true일 때만 강조 색상 표시
    let alwaysShowCategoryHighlight: Bool

    /// 버튼 클릭 시 실행될 동작 (클로저)
    let action: () -> Void

    /// 카테고리 버튼 초기화 메서드
    /// - Parameters:
    ///   - category: 카테고리 이름입니다. (버튼에 표시될 텍스트)
    ///   - categoryColor: 카테고리 강조 색상입니다. (선택된 상태에서 적용될 색상)
    ///   - alwaysShowCategoryHighlight: 카테고리 강조 색상을 항상 표시할지 여부 (기본값: false)
    ///   - action: 버튼 클릭 시 실행될 동작을 지정하는 클로저입니다.
    init(
        category: String,
        categoryColor: Color,
        alwaysShowCategoryHighlight: Bool = false,
        action: @escaping () -> Void
    ) {
        self.category = category
        self.categoryColor = categoryColor
        self.alwaysShowCategoryHighlight = alwaysShowCategoryHighlight
        self.action = action
    }

    var body: some View {
        Button {
            action()
            isCategoryOn.toggle()
        } label: {
            HStack {
                Text("# \(category)")
                    .if(alwaysShowCategoryHighlight) { view in
                        view.foregroundStyle(.label)
                    }
                    .if(!alwaysShowCategoryHighlight) { view in
                        view.foregroundColor(isCategoryOn ? .label : .gray)
                    }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
        .fontWeight(.light)
        .if(alwaysShowCategoryHighlight) { view in
            view.background(categoryColor.opacity(0.33))
        }
        .if(!alwaysShowCategoryHighlight) { view in
            view.background(isCategoryOn ? categoryColor.opacity(0.33): .gray.opacity(0.1))
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

extension CategoryButton: Identifiable {
    var id: String { category }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: 10) {
            CategoryButton(category: "카테고리", categoryColor: .blue, alwaysShowCategoryHighlight: true) { }
            CategoryButton(category: "카테고리", categoryColor: .green) { }
            CategoryButton(category: "카테고리", categoryColor: .red) { }
            CategoryButton( category: "카테고리", categoryColor: .yellow) { }
        }
    }
    .scrollIndicators(.hidden)
}
