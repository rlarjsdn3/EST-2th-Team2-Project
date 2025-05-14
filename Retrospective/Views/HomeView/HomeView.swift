//
//  HomeView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/12/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {

    @State var filterSelectViewPresented: Bool = false
    @State var isDescending: Bool = true
    @State var filteringCategories: Set<String> = []

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

    var groupedByMonthAndDay: [String: [String: [Diary]]] {
        filteredDiaries.groupByMonthAndDay()
    }


    var body: some View {
        NavigationStack {
            VStack {

                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach (filteredCategories, id: \.self ) {category in
                                CategoryButton(isCategoryOn: .constant(true), category: category.name, categoryColor: category.color)


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
                .padding(.horizontal, 20)

                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(groupedByMonthAndDay.keys.sorted(by: { isDescending ? $0 > $1 : $0 < $1 }), id: \.self) { monthKey in
                            if let days = groupedByMonthAndDay[monthKey] {

                                Section(header: MonthHeader(title: monthKey)) {
                                    ForEach(days.keys.sorted(by: { isDescending ? $0 > $1 : $0 < $1 }), id: \.self) { dayKey in
                                        if let diaries = days[dayKey] {
                                            Section(header: DayHeader(title: dayKey)) {
                                                ForEach(diaries) { diary in
                                                    VStack(alignment: .leading) {
                                                        CardUIView(diary: diary)
                                                    }


                                                    .padding(.vertical, 4)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .background(Color.gray.opacity(0.05))
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
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

struct MonthHeader: View {
    let title: String
    var body: some View {
        HStack {

            Text(title)
                .foregroundStyle(Color.secondary)
                .font(.title)


            Spacer()

        }
        .frame(maxWidth: .infinity)
        .background(Color.appLightPeach)
    }
}

struct DayHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.secondary)
                .font(.title3)


            Spacer()
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(PersistenceManager.previewContainer)
}
