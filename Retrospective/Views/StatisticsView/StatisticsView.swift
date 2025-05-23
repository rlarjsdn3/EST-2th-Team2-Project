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
    @State private var chartsDatas: [CategoryChartsData] = []

    private let etcString = "기타"
    private var etc: Category = Category(name: "기타", color: .secondary)

    var body: some View {
        RetrospectiveNavigationStack {
            Group {
                if chartsDatas.isEmpty {
                    emptyStateView
                } else {
                    donutChartsScrollView
                }
            }
            .onChange(of: dateRange, initial: true) { _, _ in
                guard let dateRange else { return }
                chartsDatas = groupDiariesByCategory(range: dateRange)
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
                DonutChartsView(datas: chartsDatas)
                    .padding(.horizontal)
                    .padding(.top, 50)
                    .padding(.bottom, 10)

                Divider()

                CategoryChartsListView(datas: chartsDatas.prefix(length: 5))
                    .padding(.top)

                moreLinkButton
            }
        }
        .background(.appLightPeach)
        .contentMargins(.bottom, 80, for: .scrollContent)
        .scrollIndicators(.hidden)
    }

    var categoryDetailCardView: some View {
        VStack {
            Text("세부 정보")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .foregroundStyle(.secondary)

            ForEach(chartsDatas.prefix(5)) { data in
                HStack {
                    HStack(alignment: .firstTextBaseline) {
                        Circle()
                            .stroke(data.color, lineWidth: 3.5)
                            .frame(width: 10, height: 10)

                        Text("\(data.name)")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(data.count)개")
                        Text("(\(data.ratePercentage))")
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
        .padding()
    }

    var moreLinkButton: some View {
        NavigationLink {
            StatisticsListView(datas: chartsDatas)
        } label: {
            HStack {
                HStack(alignment: .firstTextBaseline) {
                    Text("더보기")
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .fontWeight(.light)
                }
                .foregroundStyle(.label)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .cornerRadius(.background, radius: 8)
            .defaultShadow(.black.opacity(0.11))
            .padding(.horizontal)
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
            // '카테고리 없음' 범례를 제일 뒤로 보내기
            let isEqual1 = $0.name == etcString
            let isEqual2 = $1.name == etcString
            if isEqual1 || isEqual2 {
                return !isEqual1 && isEqual2
            }
            // 카테고리 개수가 같다면
            if $0.count == $1.count {
                // 이름 오름차순 정렬
                return $0.name < $1.name
            }
            // 개수 내림차순 정렬
            return $0.count > $1.count
        }
    }

    func groupCategoriesByCount(from diaries: [Diary]) -> (CategoryDict, Int) {
        var total: Int = 0
        var categoryDict: CategoryDict = [:]
        for diary in diaries {
            if diary.categories.isEmpty {
                total += 1
                categoryDict[etc] = categoryDict[etc, default: 0] + 1
            } else {
                for category in diary.categories {
                    total += 1
                    categoryDict[category] = categoryDict[category, default: 0] + 1
                }
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
            if (diary.createdDate >= lowerBound && diary.createdDate < upperBound) {
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
