//
//  DateRangeSelectionView.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct DateRangeSelectionView: View {

    @State private var dateSelection: Date? = .now
    @Binding var isPresented: Bool
    @Binding var periodSelection: StatisticsPeriod
    @Binding var dateRange: Range<Date>?

    init(
        isPresented: Binding<Bool>,
        periodSelection: Binding<StatisticsPeriod>,
        dateRange: Binding<Range<Date>?>
    ) {
        self._isPresented = isPresented
        self._periodSelection = periodSelection
        self._dateRange = dateRange
    }

    var body: some View {
        VStack {
            Text("날짜를 선택하세요.")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)

            Picker("Period Picker", selection: $periodSelection) {
                ForEach(StatisticsPeriod.allCases) { period in
                    Text(period.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 60)

            HStack {
                CircleButton(systemName: "arrow.left") {
                    switch periodSelection {
                    case .week:
                        goPreviousWeek()
                    case .month:
                        goPreviousMonth()
                    }
                }

                Spacer()

                CircleButton(systemName: "arrow.right") {
                    switch periodSelection {
                    case .week:
                        goNextWeek()
                    case .month:
                        goNextMonth()
                    }
                }
            }
            .overlay {
                Group {
                    switch periodSelection {
                    case .week:
                        VStack {
                            HStack {
                                Text(dateSelection?.previousWeek?.formatted(.yyyyMMdd) ?? "Nil")
                                Text("~")
                            }
                            .offset(x: -15)
                            Text(dateSelection?.nextWeek?.formatted(.yyyyMMdd) ?? "Nil")
                                .offset(x: 15)
                        }
                        .font(.headline)
                    case .month:
                        Text(dateSelection?.formatted(.yyyyMM) ?? "Nil")
                            .font(.largeTitle)

                    }
                }
                .monospacedDigit()
                .fontWeight(.semibold)
            }
            .onChange(of: periodSelection) { _, _ in
                dateSelection = .now
            }
            .padding(.vertical)

            RoundedRectButton(title: "확인") {
                didTapConfirmButton()
            }
            .padding(.top, 60)
        }
        .padding(8)
    }
}

extension DateRangeSelectionView {

}


// MARK: - Logics

extension DateRangeSelectionView {

    func didTapConfirmButton() {
        switch periodSelection {
        case .week:
            dateRange = dateSelection?.weekRange
        case .month:
            dateRange = dateSelection?.monthRange
        }
        isPresented = false
    }

    func goNextWeek() {
        dateSelection = dateSelection?.nextWeek
    }

    func goPreviousWeek() {
        dateSelection = dateSelection?.previousWeek
    }

    func goNextMonth() {
        dateSelection = dateSelection?.nextMonth
    }

    func goPreviousMonth() {
        dateSelection = dateSelection?.previousMonth
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var isPresented: Bool = true
    @Previewable @State var periodSelection: StatisticsPeriod = .week
    @Previewable @State var dateRange: Range<Date>? = Date.now.weekRange
    DateRangeSelectionView(
        isPresented: $isPresented,
        periodSelection: $periodSelection,
        dateRange: $dateRange
    )
}
