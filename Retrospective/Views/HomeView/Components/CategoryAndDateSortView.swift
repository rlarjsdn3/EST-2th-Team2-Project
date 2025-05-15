//
//  CategoryAndDateSortView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/15/25.
//

import SwiftUI

/// 선택된 카테고리 목록과 정렬 순서 토글을 함께 표시하는 필터/정렬 UI 뷰입니다.
///
/// 수평 스크롤 가능하게 카테고리 버튼들을 표시하고,
/// 오른쪽에는 날짜 정렬 방향을 조절할 수 있는 토글 버튼이 있습니다.
/// 넓은 화면일 경우 좌우 패딩이 더 크게 적용됩니다.
///
/// - Parameters:
///   - filteredCategories: 화면에 표시할 카테고리 배열 (필터링 된 카테고리 배열)
///   - isDescending: 날짜 정렬 기준 (최신순: true, 오래된 순: false)
struct CategoryAndDateSortView: View {
    let filteredCategories: [Category]
    @Binding var isDescending: Bool
    @Environment(\.horizontalSizeClass) var hSizeClass

    var body: some View {
        HStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack {
                    ForEach (filteredCategories, id: \.self ) {category in
                        CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }
                    }
                }
            }
            
            ToggleSortOrder { isDescending in
                self.isDescending = isDescending
            }
            .padding(.leading)
        }
        .frame(minHeight: 40)
        .padding(.horizontal, hSizeClass == .regular ? 30 : 15)
    }
}
