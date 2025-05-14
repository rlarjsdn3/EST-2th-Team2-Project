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
            VStack {
                
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
                        HStack(spacing: 0) {
                            Text(currentSearchScopeText)
                            Image(systemName: "arrowtriangle.down")
                        }

                    }
                    .foregroundStyle(Color.label)
                }
                .padding()
                .background(Color.appLightGray.opacity(0.33))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .padding(.top, hSizeClass == .regular ? 20 : 0)

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
                                Text("최신순 ")
                                Image(systemName: "arrowtriangle.down")
                            }
                        } else {
                            HStack(spacing: 0) {
                                Text("오래된순 ")
                                Image(systemName: "arrowtriangle.up")
                            }
                        }
                        
                    }
                    .foregroundStyle(Color.label)
                    .padding(.horizontal, 15)
                }
                .padding(.top, 5)

                if searchText.isEmpty {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("\n검색어를 입력해주세요!")
                    }
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundStyle(Color.secondary)
                    
                } else {
                    if hSizeClass == .regular {
                        CardScrollViewForPad(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                    } else {
                        CardScrollView(isDescending: $isDescending, groupedByMonthAndDay: groupedByMonthAndDay)
                    }
                }
                
            }
            .padding(.horizontal, hSizeClass == .regular ? 30 : 15)
            .background(Color.appLightPeach)
            .floatingSheet(isPresented: $isPresentedFilterSelectView) {
                FilterSelectView(filteringCategories: $filteringCategories, isPresentedFilterSelectView: $isPresentedFilterSelectView)
                //                    .presentationDetents([.height(200), .fraction(0.7)])
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
    SearchView()
        .modelContainer(PersistenceManager.previewContainer)
}
