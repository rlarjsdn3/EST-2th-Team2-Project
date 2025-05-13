//
//  FilterView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/13/25.
//

import SwiftData
import SwiftUI

struct FilterSelectView: View {
    @Binding var filteringCategories: Set<String>

    @Query var allCategories: [Category]

    var categoryNames: [String] {
        allCategories.map { $0.name }
    }

    var body: some View {
        List {
            ForEach(categoryNames, id: \.self) { category in
                HStack {
                    Text(category)

                    Spacer()

                    if filteringCategories.contains(category) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                    }
                }
                .contentShape(Rectangle()) // 전체 영역 클릭 가능하게
                .onTapGesture {
                    toggle(category)
                }
            }
        }
    }

    private func toggle(_ category: String) {
        if filteringCategories.contains(category) {
            filteringCategories.remove(category)
        } else {
            filteringCategories.insert(category)
        }
    }
}

#Preview {
    FilterSelectView(filteringCategories: .constant(Set(["감정"])))
        .modelContainer(PersistenceManager.previewContainer)
}
