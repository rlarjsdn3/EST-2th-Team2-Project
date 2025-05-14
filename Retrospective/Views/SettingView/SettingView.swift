//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by juks86 on 5/14/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        RetrospectiveNavigationStack {
            ZStack {

                Color(.appLightPeach)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 40) {
                    HStack(spacing: 10) {
                        Image(systemName: "gearshape")
                            .font(.title3)

                        Text("설정")
                            .font(.system(size: 30, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical)

                    VStack {
                        NavigationLink(destination: CategoryView()) {
                            HStack {
                                Text("카테고리설정")
                                    .font(.headline)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(.label)
                            .padding(.horizontal, 30)
                        }

                        Divider()
                            .background(Color.appLightGray)
                            .padding(.horizontal, 30)
                    }
                    .padding(.horizontal, 10)

                    Spacer()
                }
                .padding(.top, 50)

            }
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) { }
            }
            .retrospectiveNavigationTitle("설정")
            .retrospectiveNavigationBarColor(.appLightPeach)
        }

    }
}



#Preview {
    SettingView()
        .modelContainer(PersistenceManager.previewContainer)
}
