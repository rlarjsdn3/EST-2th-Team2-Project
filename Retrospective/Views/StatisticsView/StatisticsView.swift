//
//  StatisticsView.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI
import SwiftData

enum StatisticsPeriod: String, CaseIterable, Identifiable {
    var id: Self { self }
    case week = "주"
    case month = "월"
}

struct StatisticsView: View {

    @Query private var diary: [Diary]

    @State private var isPresentDateRangePicker: Bool = false
    @State private var periodSelection: StatisticsPeriod = .week
    @State private var dateRange: Range<Date>? = Date.now.weekRange
    @State private var chartsData: [CategoryChartsData] = []

    var body: some View {
        RetrospectiveNavigationStack {
            Group {
                if chartsData.isEmpty {
                    emptyStateView
                } else {
                    donutChartsScrollView
                }
            }
            .onChange(of: dateRange, initial: true) { _, _ in
                guard let dateRange else { return }
                chartsData = groupDiariesByCategory(range: dateRange)
            }
            .overlay(alignment: .topLeading) {
                dateRangeSelectionButton
                    .padding(.top, 20)
                    .padding(.horizontal)
            }
            .retrospectiveNavigationTitle("통계")
            .retrospectiveNavigationBarColor(.appLightPeach)
        }
        .floatingSheet(isPresented: $isPresentDateRangePicker) {
            DateRangeSelectionView(
                isPresented: $isPresentDateRangePicker,
                periodSelection: $periodSelection,
                dateRange: $dateRange
            )
        }
    }
}

extension StatisticsView {

    var emptyStateView: some View {
        EmptyStateView(
            systemName: "swiftdata",
            title: "통계 데이터가 없습니다.",
            description: "일기를 작성하여 통계 데이터를 확인해보세요."
        )
        .background(.appLightPeach)
    }

    var donutChartsScrollView: some View {
        ScrollView {
            VStack {
                DonutChartsView(datas: chartsData)
                    .padding(.horizontal)
                    .padding(.top, 50)

                Divider()

                VStack {
                    Text("자세히 보기")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    categoryDetailCardView
                }
                .padding()
            }
        }
        .background(.appLightPeach)
        .contentMargins(.bottom, 80, for: .scrollContent)
        .scrollIndicators(.hidden)
    }

    var categoryDetailCardView: some View {
        ForEach(chartsData) { data in
            HStack {
                HStack(alignment: .firstTextBaseline) {
                    Circle()
                        .stroke(data.color, lineWidth: 3.5)
                        .frame(width: 10, height: 10)

                    Text("\(data.name)")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(data.count)")
                    Text(String(format: "(%.1f%%)", data.rate * 100))
                        .font(.caption)
                        .fontWeight(.light)
                }

            }
            .padding(8)
            .padding(.horizontal, 14)
            .cornerRadius(.background, radius: 8)
            .defaultShadow(.black.opacity(0.11))
        }
    }

    var dateRangeSelectionButton: some View {
        HStack {
            Button {
                isPresentDateRangePicker = true
            } label:{
                Image(systemName: "calendar")
                    .font(.title3)
                    .foregroundStyle(.black)
                    .padding(10)
                    .background(.appLightGray.opacity(0.55), in: .circle)
            }
            Spacer()
        }
    }
}


// MARK: - Logics

extension StatisticsView {

    typealias CategoryDict = [Category: Int]

    func groupDiariesByCategory(range: Range<Date>) -> [CategoryChartsData] {
        let diaries = filterDiaries(in: range)
        let (categoryDict, total) = groupCategoriesByCount(from: diaries)
        let chartsDatas = prepareDonutChartData(from: categoryDict, total: total)

        return chartsDatas.sorted {
            if $0.count == $1.count {
                return $0.name < $1.name
            }
            return $0.count > $1.count
        }
    }

    func groupCategoriesByCount(from diaries: [Diary]) -> (CategoryDict, Int) {
        var total: Int = 0
        var categoryDict: CategoryDict = [:]
        for diary in diaries {
            for category in diary.categories {
                total += 1
                categoryDict[category] = categoryDict[category, default: 0] + 1
            }
        }
        return (categoryDict, total)
    }

    func prepareDonutChartData(from dictCategories: CategoryDict, total: Int) -> [CategoryChartsData] {
        var chartData: [CategoryChartsData] = []
        for (category, count) in dictCategories {
            let rate: Double = Double(count) / Double(total)
            let data = CategoryChartsData(
                name: category.name,
                count: count,
                rate: rate,
                color: category.color
            )
            chartData.append(data)
        }
        return chartData
    }

    func filterDiaries(in dateRange: Range<Date>) -> [Diary] {
        let lowerBound = dateRange.lowerBound
        let upperBound = dateRange.upperBound

        var filterdDiary: [Diary] = []
        for diary in self.diary {
            if (diary.createdDate >= lowerBound && diary.createdDate <= upperBound) {
                filterdDiary.append(diary)
            }
        }
        return filterdDiary
    }
}

#Preview {
    StatisticsView()
        .modelContainer(PersistenceManager.previewContainer)
}
