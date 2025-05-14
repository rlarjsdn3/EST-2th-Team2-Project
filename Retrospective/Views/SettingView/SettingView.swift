//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by juks86 on 5/14/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        RetrospectiveNavigationStack {

            NavigationLink(destination: CategoryView()) {

                HStack {
                    Text("카테고리")
                        .font(.headline)
                        .foregroundStyle(.label)

                    Spacer()

                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.label)
                .padding(.horizontal, 30)
                .frame(width: .infinity, height: 80)
                .background(Color.appLightSkyBlue)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .top)
            .background(Color.appLightPeach)
            .ignoresSafeArea(.all)

            .retrospectiveNavigationTitle("설정")
            .retrospectiveNavigationBarColor(.appLightPeach)
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) {
                    dismiss()
                }
            }
        }
    }
}



#Preview {
    SettingView()
        .modelContainer(PersistenceManager.previewContainer)
}
