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
            VStack(spacing: 20) {
                NavigationLink(destination: CategoryView()) {
                    HStack {
                        Text("카테고리")
                            .font(.headline)
                            .foregroundStyle(.label)

                        Spacer()

                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 30)
                    .frame(height: 60)
                    .background(Color.appLightSkyBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding()
                }
                .padding(.bottom, -40)

                Button(action: {
//                    UIApplication.shared.open(gmailURL)
                }) {
                    HStack {
                        Text("문의하기")
                            .font(.headline)
                            .foregroundStyle(.label)

                        Spacer()

                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal,30)
                    .frame(height: 60)
                    .background(Color.appLightSkyBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding()
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.appLightPeach)
            .ignoresSafeArea()

            .retrospectiveNavigationTitle("설정")
            .retrospectiveNavigationBarColor(.appLightPeach)
        }
    }
//    var gmailURL: URL {
//        let to = "OurDiary@gmail.com"
//        let subject = "Our Diary 문의사항"
//        let body = """
//        아래에 내용을 입력해주세요.
//        
//        단말기 명:
//        앱 버전:
//        문의사항:
//        """
//
//        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//
//        let urlString = "https://mail.google.com/mail/?view=cm&fs=1&to=\(to)&su=\(encodedSubject)&body=\(encodedBody)"
//        return URL(string: urlString)!
//    }
}

#Preview {
    SettingView()
        .modelContainer(PersistenceManager.previewContainer)
}
