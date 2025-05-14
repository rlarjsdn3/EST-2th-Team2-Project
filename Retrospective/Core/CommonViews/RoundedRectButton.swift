//
//  RoundedRectButton.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

struct RoundedRectButton: View {

    let title: String
    let color: Color
    let action: () -> Void

    init(
        title: String,
        color: Color = .appLightGray.opacity(0.55),
        action: @escaping () -> Void
    ) {
        self.title = title
        self.color = color
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.label)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .cornerRadius(color, radius: 18)
        }
    }
}

#Preview {
    RoundedRectButton(title: "확인") { }
}
