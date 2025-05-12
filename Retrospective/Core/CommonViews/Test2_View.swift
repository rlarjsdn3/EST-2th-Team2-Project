//
//  Test2_View.swift
//  Retrospective
//
//  Created by juks86 on 5/12/25.
//

import SwiftUI

struct Test2_View: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.red)
            Text("Search")
                .foregroundStyle(.white)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    Test2_View()
}
