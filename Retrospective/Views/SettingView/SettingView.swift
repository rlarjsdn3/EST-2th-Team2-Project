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
            ScrollView {
                VStack(spacing: 50) {
                    VStack(spacing: -5) {
                        Text("카테고리")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 30)

                        NavigationLink(destination: CategoryView()) {
                            HStack {
                                Text("카테고리")
                                    .font(.headline)
                                    .foregroundStyle(.label)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.label)
                            }
                            .padding(.horizontal, 30)
                            .frame(height: 60)
                            .background(Color.appLightSkyBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .padding()
                        }
                        .padding(.bottom, -40)
                    }
                    .padding(.top)

                    VStack(spacing: -5) {
                        Text("문의")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 30)

                        Button(action: {
                            MailComposeViewController.shared.sendEmail()
                        }) {
                            HStack {
                                Text("이메일로 문의하기")
                                    .font(.headline)
                                    .foregroundStyle(.label)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.label)
                            }
                            .padding(.horizontal,30)
                            .frame(height: 60)
                            .background(Color.appLightSkyBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .retrospectiveNavigationTitle("설정")
                .retrospectiveNavigationBarColor(.appLightPeach)
            }
            .background(Color.appLightPeach)
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SettingView()
        .modelContainer(PersistenceManager.previewContainer)
}
