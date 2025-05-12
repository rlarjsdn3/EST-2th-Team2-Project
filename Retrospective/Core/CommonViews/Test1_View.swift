//
//  Test1_View.swift
//  Retrospective
//
//  Created by juks86 on 5/12/25.
//

import SwiftUI

struct Test1_View: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.green)
            Text("Home1")
                .foregroundStyle(.white)
        }
        .ignoresSafeArea(.all)

    }

}

#Preview {
    Test1_View()
}
