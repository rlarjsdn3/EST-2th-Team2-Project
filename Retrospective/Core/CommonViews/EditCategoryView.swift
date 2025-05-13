//
//  EditCategoryView.swift
//  Retrospective
//
//  Created by juks86 on 5/13/25.
//

import SwiftUI
import SwiftData

struct EditCategoryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var category: Category
    @State private var editedName: String
    @State private var editedColor: Color

    init(category: Category) {
        self.category = category
        _editedName = State(initialValue: category.name)
        _editedColor = State(initialValue: category.color)
    }

    var body: some View {
        RetrospectiveNavigationStack{

            Text("dsdad")
                .retrospectiveLeadingToolBar {
                    RetrospectiveToolBarItem(.symbol("chevron.left")) { }
                }
                .retrospectiveNavigationTitle("카테고리 변경")
                .retrospectiveNavigationBarColor(.appLightPeach)
        }
    }
}
#Preview {
    let previewCategory = Category(name: "샘플 카테고리")
    EditCategoryView(category: previewCategory)
        .modelContainer(PersistenceManager.previewContainer)
}

