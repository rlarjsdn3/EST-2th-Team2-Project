//
//  CircleButton.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct CircleButton: View {

    ///
    private let systemName: String
    ///
    private let action: () -> Void

    /// <#Description#>
    /// - Parameters:
    ///   - systemName: <#systemName description#>
    ///   - action: <#action description#>
    init(systemName: String, action: @escaping () -> Void) {
        self.action = action
        self.systemName = systemName
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.title)
                .foregroundStyle(.background)
                .padding()
                .background(.appLightPeach, in: .circle)

        }

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButton(systemName: "arrow.right") { }
}
