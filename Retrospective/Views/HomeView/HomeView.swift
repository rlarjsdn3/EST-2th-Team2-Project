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

                CategoryAndDateSortView(filteredCategories: filteredCategories, isDescending: $isDescending)
                    .padding(.top, 5)
                    .padding(.bottom, 15)

                if allDiaries.isEmpty {
                        EmptyStateView(
                            systemName: "swiftdata",
                            title: "저장된 다이어리가 없습니다.",
                            description: "새로운 기록을 남겨보세요."
                        )
                        .padding(.bottom, 150)

                } else {

                    if filteredDiaries.isEmpty {
                        EmptyStateView(
                            systemName: "swiftdata",
                            title: "검색된 다이어리가 없습니다.",
                            description: "카테고리의 첫 기록을 남겨보세요."
                        )
                        .padding(.bottom, 150)
                        
                    } else {
                        if hSizeClass == .regular {
                            CardScrollViewForPad(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                        } else {
                            CardScrollView(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                        }
                    }
                }
            }
            .background(Color.appLightPeach)
            .retrospectiveNavigationTitle("홈")
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
        .floatingSheet(isPresented: $isPresentedFilterSelectView) {
            FilterSelectView(filteringCategories: $filteringCategories, isPresentedFilterSelectView: $isPresentedFilterSelectView)
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(PersistenceManager.previewContainer)
}
