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

                    SearchView() // searchView() 넣어주세요
                        .tag(Tab.search)

                    StatisticsView()
                        .tag(Tab.statistic)

                    WritingView(diary: .mock[0])
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
                        .font(.title)
                        .foregroundStyle(selected == .home ? .label : .secondary.opacity(0.55))
                }
            }
            Spacer()

            ///검색버튼
            Button{
                selected = .search
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundStyle(selected == .search ? .label : .secondary.opacity(0.55))
                }
            }
            Spacer()

            ///통계버튼
            Button{
                selected = .statistic
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "chart.pie")
                        .font(.title)
                        .foregroundStyle(selected == .statistic ? .label : .secondary.opacity(0.55))
                }
            }
            Spacer()

            ///설정버튼
            Button{
                selected = .setting
            } label: {
                VStack(alignment:.center) {
                    Image(systemName: "gearshape")
                        .font(.title)
                        .foregroundStyle(selected == .setting ? .label : .secondary.opacity(0.55))
                }

            }
            Spacer()

        }
        .frame(width: 350 , height: 80)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.33), radius: 15, x: 5, y: 5)
    }

}

#Preview {
    ContentView()
        .modelContainer(PersistenceManager.previewContainer)
}
