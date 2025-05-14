//
//  ContentView.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI
///탭바 구현 코드입니다.
///주석 처리된 곳에  View넣어주세요 코드 마지막줄 쪽에도 넣어주셔야합니다. 총 두곳에 넣어주시면 됩니다.
struct ContentView: View {
    ///Tag에서 사용할 탭 열거형
    enum Tab: Hashable {
        case search, home, statistic, setting
    }

    @State private var selected: Tab = .home

    init() {
        UITabBar.appearance().isHidden = true
    }

    ///탭바 커스텀을 위해 탭바의 고정된 자리 삭제
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selected) {
                Group {
                    CategoryManagementView() //TODO: HomeView() 넣어주세요
                        .tag(Tab.home)

                    Test2_View()// searchView() 넣어주세요
                        .tag(Tab.search)

                    StatisticsView()
                        .tag(Tab.statistic)

                    StatisticsView()
                        .tag(Tab.setting)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            

            tabBar
                .padding(.bottom, -10)
        }
        .ignoresSafeArea(.keyboard)
    }


    ///탭바 커스텀
    var tabBar: some View {
        HStack {
            Spacer()
            ///홈버튼
            Button{
                selected = .home
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.black)

                }
            }
            Spacer()

            ///검색버튼
            Button{
                selected = .search
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.label)
                }
            }
            Spacer()

            ///통계버튼
            Button{
                selected = .statistic
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "chart.pie")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.label)
                }
            }
            Spacer()

            ///설정버튼
            Button{
                selected = .setting
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.label)
                }

            }
            Spacer()

        }

        .frame(width: 350 , height: 80)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.33), radius: 15, x: 5, y: 5)

    }

    ///각 탭에서 보여지는 실제 화면

    struct  HomeView: View {
        var body: some View {
            CategoryManagementView()//TODO: HomeView() 넣어주세요

        }
    }

    struct SearchView: View {
        var body: some View {
            WritingView(diary: .mock[0])// searchView() 넣어주세요
        }
    }

    struct statisticView: View {
        var body: some View {
            Test3_View()// statistiView() 넣어주세요
        }
    }

    struct SettingView: View {
        var body: some View {// settingView() 넣어주세요
            Test4_View()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PersistenceManager.previewContainer)
}
