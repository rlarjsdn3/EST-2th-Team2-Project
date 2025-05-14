//
//  HomeView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/12/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {

    @State var isPresentedFilterSelectView: Bool = false
    @State var isPresentedWritingView: Bool = false
    @State var isDescending: Bool = true
    @State var filteringCategories: Set<String> = []

    @Query var allDiaries: [Diary]
    @Query var allCategories: [Category]

    @Environment(\.horizontalSizeClass) var hSizeClass

    var filteredCategories: [Category] {
        return allCategories.filter { category in
            filteringCategories.contains(category.name)
        }
    }

    var filteredDiaries: [Diary] {
        guard !filteringCategories.isEmpty else { return allDiaries }

        return allDiaries.filter { diary in
            // 하나라도 겹치면 통과
            let categoryNames = diary.categories.map { $0.name }
            return !filteringCategories.isDisjoint(with: categoryNames)
        }
    }

    var groupedByMonthAndDay: [String: [String: [Diary]]] {
        filteredDiaries.groupByMonthAndDay()
    }


    var body: some View {
        RetrospectiveNavigationStack {
            VStack(spacing: 0) {
                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach (filteredCategories, id: \.self ) {category in
                                CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }
                            }
                        }
                    }

                    Button {
                        isDescending.toggle()
                    } label: {
                        if isDescending {
                            HStack(spacing: 0) {
                                Text("최신순")
                                Image(systemName: "arrowtriangle.down")
                            }
                        } else {
                            HStack(spacing: 0) {
                                Text("오래된순")
                                Image(systemName: "arrowtriangle.up")
                            }
                        }

                    }
                    .foregroundStyle(Color.label)
                }
                .padding(.top, 20)
                .padding(.horizontal, hSizeClass == .regular ? 30 : 15)

                if hSizeClass == .regular {
                    CardScrollViewForPad(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                } else {
                    CardScrollView(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                }
            }
            .background(Color.appLightPeach)
            .floatingSheet(isPresented: $isPresentedFilterSelectView) {
                FilterSelectView(filteringCategories: $filteringCategories, isPresentedFilterSelectView: $isPresentedFilterSelectView)
            }
            .retrospectiveNavigationTitle("Our Camp Diary")
            .retrospectiveNavigationBarColor(.appLightPeach)
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("slider.horizontal.3")) {
                    isPresentedFilterSelectView = true
                }
            }
            .retrospectiveTrailingToolbar {
                RetrospectiveToolBarItem(.symbol("plus")) {
                    isPresentedWritingView = true
                }
            }
            .navigationDestination(isPresented: $isPresentedWritingView, destination: {
                WritingView(diary: nil)
            })
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(PersistenceManager.previewContainer)
}
