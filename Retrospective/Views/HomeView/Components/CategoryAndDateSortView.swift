//
//  CategoryAndDateSortView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/15/25.
//

import SwiftUI

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
