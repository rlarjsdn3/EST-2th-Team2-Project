//
//  CardScrollView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//

import SwiftUI

/// 월/일 기준으로 그룹화된 다이어리 항목을 단일 열로 스크롤 표시하는 뷰입니다.
///
/// 월(MonthHeader) → 일(DayHeader) → 카드(CardUIView)의 계층 구조로 구성되며,
/// 각 카드 항목은 VStack 안에서 하나씩 세로로 나열됩니다.
///
/// - 기능:
///   - 날짜 순서를 정렬방향을 정할 수 있도록 `isDescending`을 바인딩으로 받습니다.
///   - 각 년/월 헤더는 `pinnedViews`로 고정되어 스크롤 시 따라옵니다.
///   - 같은 날에 생성된 카드들은 제목(title) 내림차순으로 정렬됩니다.
///
/// - Parameters:
///   - groupedByMonthAndDay: `[월: [일: [Diary]]]` 구조의 정렬된 다이어리 데이터
///   - isDescending: 정렬 순서 설정 바인딩 (true일 경우 최신순)
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
                                        ForEach(diaries.sorted(by: { $0.title < $1.title })) { diary in
                                            VStack(alignment: .leading) {
                                                CardUIView(diary: diary)
                                            }
                                            .padding(.horizontal)
                                            .padding(.bottom, 20)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .contentMargins(.bottom, 80, for: .scrollContent)
    }
}
