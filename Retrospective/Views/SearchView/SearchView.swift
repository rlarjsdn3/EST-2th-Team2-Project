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

    var body: some View {
        RetrospectiveNavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack {
                        CustomTextField(placeholder: "검색 키워드를 작성해주세요.", text: $searchText)
                    }

                    Menu {
                        Button {
                            searchingInTitle = true
                            searchingInContents = false
                        } label: {
                            HStack {
                                Text("제목만")

                                Spacer()

                                if searchingInTitle && !searchingInContents {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }

                        Button {
                            searchingInTitle = false
                            searchingInContents = true
                        } label: {
                            Text("내용만")

                            Spacer()

                            if !searchingInTitle && searchingInContents {
                                Image(systemName: "checkmark")
                            }
                        }

                        Button {
                            searchingInTitle = true
                            searchingInContents = true
                        } label: {
                            Text("제목 + 내용")

                            Spacer()

                            if searchingInTitle && searchingInContents {
                                Image(systemName: "checkmark")
                            }
                        }
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.label)
                        .padding(.trailing)
                        .padding(.vertical)
                    }
                }


                if searchText.isEmpty {
                    EmptyStateView(
                        systemName: "swiftdata",
                        title: "검색어가 없습니다.",
                        description: "키워드를 통해 원하는 다이어리를 찾아보세요."
                    )
                    .padding(.bottom, 150)
                    .ignoresSafeArea(.keyboard)

                } else {
                    if searchedDiaries.isEmpty {
                        EmptyStateView(
                            systemName: "swiftdata",
                            title: "검색된 다이어리가 없습니다.",
                            description: "다른 키워드를 입력해주세요."
                        )
                        .padding(.bottom, 150)
                        .ignoresSafeArea(.keyboard)
                    } else {
                        Group {
                            if hSizeClass == .regular {
                                CardScrollViewForPad(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                            } else {
                                CardScrollView(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                            }
                        }
                        .padding(.top, 25)
                    }
                }
            }
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }
            .overlay(alignment: .topTrailing) {
                CategoryAndDateSortView(filteredCategories: filteredCategories, isDescending: $isDescending)
                    .padding(.bottom)
                    .padding(.top, 63)
            }
            .background(Color.appLightPeach)
            .floatingSheet(isPresented: $isPresentedFilterSelectView) {
                FilterSelectView(filteringCategories: $filteringCategories, isPresentedFilterSelectView: $isPresentedFilterSelectView)
            }
            .retrospectiveNavigationTitle("검색")
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
