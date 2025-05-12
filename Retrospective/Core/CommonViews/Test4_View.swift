//
//  Test4_View.swift
//  Retrospective
//
//  Created by juks86 on 5/12/25.
//

import SwiftUI

struct Test4_View: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
            Text("Settings")
                .foregroundStyle(.white)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    Test4_View()
}
