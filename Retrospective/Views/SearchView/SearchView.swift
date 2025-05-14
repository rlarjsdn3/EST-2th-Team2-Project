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

    @State var filterSelectViewPresented: Bool = false
    @State var isDescending: Bool = true
    @State var filteringCategories: Set<String> = []
    @State var searchText: String = ""

    @State var searchingInTitle: Bool = true
    @State var searchingInContents: Bool = false

    @Query var allDiaries: [Diary]
    @Query var allCategories: [Category]

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
        case (true, true): return "제목 + 내용"
        case (true, false): return "제목만"
        case (false, true): return "내용만"
        default: return "검색 안 함"
        }
    }

    var body: some View {
        NavigationStack {
            VStack {

                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach (filteredCategories, id: \.self ) {category in
                                CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }


                            }
                        }
                        .padding(.vertical, 5)

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
                }

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.secondary)
                        .bold()

                    TextField("Search", text: $searchText, prompt: Text("Search")
                        .foregroundStyle(Color.secondary))

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
                        Label(currentSearchScopeText, systemImage: "line.3.horizontal.decrease.circle")
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }

                if searchText.isEmpty {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .bold()
                        Text("검색어를 입력해주세요!")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundStyle(Color.secondary)

                } else {
                    CardScrollView(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                }

            }
            .background(Color.appLightPeach)
            .padding(.horizontal)
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    Button("Two") {
                        filterSelectViewPresented = true
                    }
                }
            }
            .sheet(isPresented: $filterSelectViewPresented) {
                NavigationStack {
                    FilterSelectView(filteringCategories: $filteringCategories)
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(PersistenceManager.previewContainer)
}
