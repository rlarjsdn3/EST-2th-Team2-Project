//
//  CardScrollView 2.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//


//
//  CardScrollView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//

import SwiftUI

struct CardScrollViewForPad: View {
    @Binding var isDescending: Bool

    let groupedByMonthAndDay: [String: [String: [Diary]]]

    let columns = [
        GridItem(.flexible(), spacing: 12, alignment: .top),
        GridItem(.flexible(), spacing: 12, alignment: .top)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                ForEach(groupedByMonthAndDay.keys.sorted(by: { isDescending ? $0 > $1 : $0 < $1 }), id: \.self) { monthKey in
                    if let days = groupedByMonthAndDay[monthKey] {

                        Section(header: MonthHeader(title: monthKey)) {
                            ForEach(days.keys.sorted(by: { isDescending ? $0 > $1 : $0 < $1 }), id: \.self) { dayKey in
                                if let diaries = days[dayKey] {

                                    Section(header: DayHeader(title: dayKey)) {
                                        LazyVGrid(columns: columns, spacing: 0) {
                                            ForEach(diaries.sorted(by: { $0.title > $1.title })) { diary in
                                                CardUIView(diary: diary)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .background(Color.gray.opacity(0.05))
                                                    .cornerRadius(10)
                                                    .padding(.vertical, 10)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
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
