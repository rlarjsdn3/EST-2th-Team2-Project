//
//  OnboardingView.swift
//  Retrospective
//
//  Created by 정소이 on 5/15/25.
//

import SwiftUI

struct OnboardingView: View {

    var body: some View {
        TabView {
            VStack {
                HStack{
                    Text("Our\nCamp\nDiary")
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                        .padding()

                    Spacer()
                }
                .padding(.top, 60)
                .padding(.leading, 20)

                Spacer()

                HStack {
                    Spacer()

                    Image(systemName: "pencil.and.scribble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        .foregroundStyle(.appBlue)
                        .padding(.trailing, 50)
                }
            }

            VStack(spacing: 20){
                Text("즐거운 날에도")
                Text("슬픈 날에도")
                Text("그저그런 날에도")
            }
            .font(.system(size: 30))
            .fontWeight(.semibold)

            VStack {
                Image(systemName: "eyes")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.label)
                    .padding()

                Text("간편하게")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding()

                Text("그날의 추억을 기록해보세요")
                    .font(.title2)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }

//    /// 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수
//    /// @AppStorage에 저장되어 앱 종료 후에도 유지됨
//    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
//
//    var body: some View {
//        HomeView()
//            // 앱 최초 구동 시 전체화면으로 OnboardingTabView 띄우기
//            .fullScreenCover(isPresented: $isFirstLaunching) {
//                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
//            }
//    }
}

#Preview {
    OnboardingView()
}
