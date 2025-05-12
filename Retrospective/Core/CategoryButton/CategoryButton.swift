//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by 정소이 on 5/12/25.
//

import SwiftUI

struct CategoryButton: View {
    @Binding var isCategoryOn: Bool

    var category: String
    var categoryColor: Color

    init(isCategoryOn: Binding<Bool>, category: String, categoryColor: Color) {
        self._isCategoryOn = isCategoryOn
        self.category = category
        self.categoryColor = categoryColor
    }

    var body: some View {
        Button {
            self.isCategoryOn.toggle()
        } label: {
            HStack {
                Text("# \(category)")
                    .fontWeight(.light)
                    .foregroundColor(isCategoryOn ? .primary : .gray)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
        .background(isCategoryOn ? categoryColor.opacity(0.33): .gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    @Previewable @State var isCategoryOn1: Bool = false
    @Previewable @State var isCategoryOn2: Bool = false
    @Previewable @State var isCategoryOn3: Bool = false
    @Previewable @State var isCategoryOn4: Bool = false

    ScrollView(.horizontal) {
        HStack(spacing: 10) {
            CategoryButton(isCategoryOn: $isCategoryOn1, category: "카테고리", categoryColor: .blue)
            CategoryButton(isCategoryOn: $isCategoryOn2, category: "카테고리", categoryColor: .green)
            CategoryButton(isCategoryOn: $isCategoryOn3, category: "카테고리", categoryColor: .red)
            CategoryButton(isCategoryOn: $isCategoryOn4, category: "카테고리", categoryColor: .yellow)
        }
    }
    .scrollIndicators(.hidden)
}
