//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by juks86 on 5/13/25.
//

import SwiftUI

struct CategoryView: View {

    @State var isCategoryOn: Bool = false
    var body: some View {
        RetrospectiveNavigationStack{

            CategoryTestView()
                .retrospectiveLeadingToolBar {
                    RetrospectiveToolBarItem(.symbol("chevron.left")) { }
                }
                .retrospectiveNavigationTitle("카테고리 관리")
                .retrospectiveNavigationBarColor(.appLightPeach)
        }
    }
}

#Preview {
    CategoryView()
        .modelContainer(PersistenceManager.previewContainer)
}
