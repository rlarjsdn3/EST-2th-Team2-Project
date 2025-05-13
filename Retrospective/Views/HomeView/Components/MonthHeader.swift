//
//  MonthHeader.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//
import SwiftUI

struct MonthHeader: View {
    let title: String
    var body: some View {
        HStack {

            Text(title)
                .foregroundStyle(Color.secondary)
                .font(.title)


            Spacer()

        }
        .frame(maxWidth: .infinity)
        .background(Color.appLightPeach)
        .padding(.bottom, 10)
    }
}
