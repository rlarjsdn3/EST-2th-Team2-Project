//
//  DayHeader.swift
//  Retrospective
//
//  Created by 신유섭 on 5/14/25.
//
import SwiftUI

struct DayHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.label)
                .font(.title3)
                .fontWeight(.bold)


            Spacer()

            Divider()
        }
        .padding(.bottom)
    }
}
