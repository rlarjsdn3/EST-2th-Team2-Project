//
//  MonthHeader.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//
import SwiftUI

struct MonthHeader: View {
    @Environment(\.horizontalSizeClass) var hSizeClass

    let title: String
    var body: some View {
        HStack {

            Text(title)
                .foregroundStyle(Color.label)
                .font(.largeTitle)
                .fontWeight(.bold)


            Spacer()

        }
        .padding(.vertical, 15)
        .padding(.horizontal, hSizeClass == .regular ? 30 : 15)
        .frame(maxWidth: .infinity)
        .background(Color.appLightPeach)

    }
}
