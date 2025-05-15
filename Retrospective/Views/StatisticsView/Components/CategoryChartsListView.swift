//
//  CategoryChartsListView.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

struct CategoryChartsListView: View {

    let datas: [CategoryChartsData]

    var body: some View {
        VStack {
            Text("세부 정보")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .foregroundStyle(.secondary)

            ForEach(datas) { data in
                categoryStatisticsRow(data: data)
            }
        }
        .padding(.horizontal)
    }
}

extension CategoryChartsListView {
    
    func categoryStatisticsRow(data: CategoryChartsData) -> some View {
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
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .cornerRadius(.background, radius: 8)
        .defaultShadow(.black.opacity(0.11))
    }
}

#Preview {
    CategoryChartsListView(datas: CategoryChartsData.mock)
}
