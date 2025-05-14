//
//  StatisticsListView.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

struct StatisticsListView: View {

    @Environment(\.dismiss) var dismiss: DismissAction

    let datas: [CategoryChartsData]

    var body: some View {
        RetrospectiveNavigationStack {
            ScrollView {
                CategoryChartsListView(datas: datas)
            }
            .contentMargins(.vertical, 18)
            .background(.appLightPeach)
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) {
                    dismiss()
                }
            }
            .retrospectiveNavigationTitle("통계 세부 정보")
            .retrospectiveNavigationBarColor(.appLightPeach)
        }
    }
}

#Preview {
    StatisticsListView(datas: CategoryChartsData.mock)
}
