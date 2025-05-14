//
//  CardScrollView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//

import SwiftUI

struct CardScrollView: View {
    @Binding var isDescending: Bool

    let groupedByMonthAndDay: [String: [String: [Diary]]]



    var body: some View {
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
}
