//
//  DonutCharts.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct CategoryChartsData: Identifiable {
    /// 고유 식별자 (UUID)
    let id = UUID()

    /// 카테고리의 이름 (차트에서 표시될 라벨)
    var name: String

    /// 카테고리의 항목 개수 (총 개수)
    var count: Int

    /// 카테고리의 비율 (0.0 ~ 1.0)
    /// - 총 개수 대비 이 카테고리의 비율을 나타냅니다.
    var rate: Double

    /// 카테고리의 색상 (차트에서 사용될 색상)
    var color: Color

    /// 카테고리의 비율을 백분율 문자열로 반환합니다.
    /// - 예: "25.0%" 또는 "12.5%"
    var ratePercentage: String {
        String(format: "%.1f%%", rate * 100)
    }
}

extension CategoryChartsData: Hashable { }

extension CategoryChartsData {

    static let mock: [CategoryChartsData] = [
        .init(name: "A", count: 10, rate: 0.05, color: .blue),
        .init(name: "B", count: 20, rate: 0.1, color: .red),
        .init(name: "C", count: 30, rate: 0.1, color: .yellow),
        .init(name: "D", count: 40, rate: 0.1, color: .green),
        .init(name: "E", count: 50, rate: 0.1, color: .purple),
        .init(name: "F", count: 60, rate: 0.1, color: .orange),
        .init(name: "G", count: 70, rate: 0.1, color: .pink),
        .init(name: "H", count: 80, rate: 0.15, color: .brown),
        .init(name: "I", count: 90, rate: 0.2, color: .black),
    ]
}



extension Array where Element == CategoryChartsData {

    /// 지정된 인덱스까지의 카테고리 비율(rate)을 누적하여 반환합니다.
    /// - Parameter index: 누적할 카테고리의 마지막 인덱스입니다.
    /// - Returns: 지정된 인덱스까지의 누적 비율 값 (Double)
    func accumulatedRate(upTo index: Int) -> Double {
        guard (0..<count) ~= index else { return 0.0 }
        return self.prefix(index).reduce(0.0) { $0 + $1.rate }
    }
}
