//
//  DonutCharts.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

/// <#Description#>
struct CategoryChartsData: Identifiable {
    let id = UUID()
    ///
    var name: String
    ///
    var count: Int
    ///
    var rate: Double
    ///
    var color: Color
}

extension CategoryChartsData: Hashable { }

extension CategoryChartsData {

    static let mock: [CategoryChartsData] = [
        .init(name: "A", count: 10, rate: 0.1, color: .blue),
        .init(name: "B", count: 20, rate: 0.2, color: .red),
        .init(name: "C", count: 30, rate: 0.3, color: .yellow),
        .init(name: "D", count: 40, rate: 0.4, color: .green),
        .init(name: "E", count: 50, rate: 0.5, color: .purple),
    ]
}



extension Array where Element == CategoryChartsData {

    func accumulatedRate(upTo index: Int) -> Double {
        var totalRate = 0.0
        for i in 0..<index { totalRate += self[i].rate }
        return totalRate
    }
}
