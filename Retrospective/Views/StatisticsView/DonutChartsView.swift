//
//  DonutChartsView.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct DonutChartsView: View {

    let datas: [CategoryChartsData]

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<datas.count, id: \.self) { index in
                    Circle()
                        .trim(
                            from: acculmanatedRate(upTo: index),
                            to: acculmanatedRate(upTo: index) + datas[index].rate
                        )
                        .stroke(datas[index].color, lineWidth: 40)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                }
            }
            .padding(50)

            ChipLayout(horizontalSpacing: 50) {
                Spacer()
                ForEach(datas) { data in
                    HStack {
                        Circle()
                            .stroke(data.color, lineWidth: 3.5)
                            .frame(width: 10, height: 10)
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(data.name)")
                            Text(String(format: "(%.1f%%)", data.rate * 100))
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
    }
}

// MARK: - Logics

extension DonutChartsView {

    func acculmanatedRate(upTo index: Int) -> Double {
        datas.accumulatedRate(upTo: index)
    }
}



#Preview {
    DonutChartsView(datas: CategoryChartsData.mock)
}
