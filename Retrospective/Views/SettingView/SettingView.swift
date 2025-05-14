//
//  SwiftUIView.swift
//  Retrospective
//
//  Created by juks86 on 5/14/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            HStack{
                Image(systemName: "gearshape")
                    .font(.title3)

                Text("설정")
                    .font(.system(size: 30, weight: .semibold, design: .default))


            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()

            NavigationLink(destination: CategoryManagementView()) {
                VStack{
                    HStack{
                        Text("카테고리설정")
                            .font(.headline)

                        Spacer()

                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.label)
                    .padding()

                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.appLightGray.opacity(0.3), lineWidth: 1)
                        .frame(height: 1)

                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}
#Preview {
    SettingView()
        .modelContainer(PersistenceManager.previewContainer)
}
