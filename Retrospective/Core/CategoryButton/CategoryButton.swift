//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by 정소이 on 5/12/25.
//

import SwiftUI

struct CategoryButton: View {
    @State var isCategoryOn: Bool = false

    let category: String
    let categoryColor: Color

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
    @Previewable @State var categoryName: String = "카테고리"
    @Previewable @State var categoryColor: Color = .blue

    ScrollView(.horizontal) {
        HStack(spacing: 10) {
            CategoryButton(category: categoryName, categoryColor: categoryColor)
            CategoryButton(category: categoryName, categoryColor: categoryColor)
            CategoryButton(category: categoryName, categoryColor: categoryColor)
            CategoryButton(category: categoryName, categoryColor: categoryColor)
        }
        .presentationDetents([.height(150), .fraction(0.8)])
    }
    .scrollIndicators(.hidden)
}
