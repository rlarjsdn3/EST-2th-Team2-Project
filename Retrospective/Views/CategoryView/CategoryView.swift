//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by juks86 on 5/13/25.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isCategoryOn: Bool = false
    var body: some View {
        RetrospectiveNavigationStack{

            CategoryListView()
                .retrospectiveLeadingToolBar {
                    RetrospectiveToolBarItem(.symbol("chevron.left")) { }
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
}

#Preview {
    CategoryView()
        .modelContainer(PersistenceManager.previewContainer)
}
