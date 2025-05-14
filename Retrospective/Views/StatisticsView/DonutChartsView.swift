//
//  DonutChartsView.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct DonutChartsView: View {

    @State private var isAnimating: Bool = false

    let datas: [CategoryChartsData]

    var countOfCategories: Int {
        datas.reduce(0, { $0 + $1.count })
    }

    var body: some View {
        VStack {
            donutChartsView
        }
        .onChange(of: datas, initial: true) { _, _ in
            isAnimating = false
            Task.delayed(byTimeInterval: 0.25) {
                withAnimation(.bouncy) {
                    isAnimating = true
                }
            }
        }
    }
}

extension DonutChartsView {

    @ViewBuilder
    var donutChartsView: some View {
        ZStack {
            ForEach(0..<datas.count, id: \.self) { index in
                Circle()
                    .trim(
                        from: fromTrimValue(index),
                        to: toTrimValue(index)
                    )
                    .stroke(datas[index].color, lineWidth: 40)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: isAnimating ? -90 : 45))
                    .scaleEffect(isAnimating ? 1.0 : 0.0)
            }
        }
        .overlay {
            totalLabel
        }
        .padding(50)

        legendChipView
    }

    var legendChipView: some View {
        ChipLayout(horizontalSpacing: 18) {
            Spacer()
            ForEach(datas.prefix(length: 5)) { data in
                HStack {
                    Circle()
                        .stroke(data.color, lineWidth: 3.5)
                        .frame(width: 10, height: 10)
                    HStack(alignment: .firstTextBaseline) {
                        Text(data.name)
                        Text(data.ratePercentage)
                            .font(.caption)
                            .fontWeight(.light)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 100)
    }

    var totalLabel: some View {
        VStack {
            Text("Total")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            Text("\(countOfCategories)")
                .font(.title2)
                .fontWeight(.bold)
        }
        .scaleEffect(isAnimating ? 1.0 : 0.0)
    }
}

// MARK: - Logics

extension DonutChartsView {

    func fromTrimValue(_ index: Int) -> Double {
        acculmanatedRate(upTo: index)
    }

    func toTrimValue(_ index: Int) -> Double {
        acculmanatedRate(upTo: index) + datas[index].rate
    }

    func acculmanatedRate(upTo index: Int) -> Double {
        datas.accumulatedRate(upTo: index)
    }
}



#Preview {
    DonutChartsView(datas: CategoryChartsData.mock)
}
