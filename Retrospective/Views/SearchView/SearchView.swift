//
//  HomeView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//


//
//  HomeView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/12/25.
//

import SwiftData
import SwiftUI

struct SearchView: View {

    @State var isPresentedFilterSelectView: Bool = false
    @State var isPresentedWritingView: Bool = false
    @State var isDescending: Bool = true
    @State var filteringCategories: Set<String> = []
    @State var searchText: String = ""

    @State var searchingInTitle: Bool = true
    @State var searchingInContents: Bool = false

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

    var searchedDiaries: [Diary] {
        return filteredDiaries.filter { diary in
            let isSearchedInTitle = diary.title.localizedCaseInsensitiveContains(searchText)
            let isSearchedInContents = diary.contents.localizedCaseInsensitiveContains(searchText)

            switch (searchingInTitle, searchingInContents) {
            case (true, true):
                return isSearchedInTitle || isSearchedInContents
            case (true, false):
                return isSearchedInTitle
            case (false, true):
                return isSearchedInContents
            case (false, false):
                return false
            }
        }
    }

    var groupedByMonthAndDay: [String: [String: [Diary]]] {
        searchedDiaries.groupByMonthAndDay()
    }

    var currentSearchScopeText: String {
        switch (searchingInTitle, searchingInContents) {
        case (true, true): return "제목 + 내용 "
        case (true, false): return "제목만 "
        case (false, true): return "내용만 "
        default: return "검색범위 선택"
        }
    }

    var body: some View {
        RetrospectiveNavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack {
                        CustomTextField(placeholder: "Search", text: $searchText)
                    }

                    Menu {
                        Button("제목만") {
                            searchingInTitle = true
                            searchingInContents = false
                        }

                        Button("내용만") {
                            searchingInTitle = false
                            searchingInContents = true
                        }

                        Button("제목 + 내용") {
                            searchingInTitle = true
                            searchingInContents = true
                        }
                    } label: {
                        HStack(spacing: 0) {
                            Text(currentSearchScopeText)
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        }
                        .padding(.trailing)
                        .padding(.vertical)
                    }
                    .fontWeight(.medium)
                    .foregroundStyle(Color.label)
                }

                CategoryAndDateSortView(filteredCategories: filteredCategories, isDescending: $isDescending)
                    .padding(.bottom)

                if searchText.isEmpty {
                        EmptyStateView(
                            systemName: "swiftdata",
                            title: "검색어가 없습니다.",
                            description: "키워드를 통해 원하는 다이어리를 찾아보세요 ."
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
            .background(Color.appLightPeach)
            .floatingSheet(isPresented: $isPresentedFilterSelectView) {
                FilterSelectView(filteringCategories: $filteringCategories, isPresentedFilterSelectView: $isPresentedFilterSelectView)
            }
            .retrospectiveNavigationTitle("Search")
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
    SearchView()
        .modelContainer(PersistenceManager.previewContainer)
}
