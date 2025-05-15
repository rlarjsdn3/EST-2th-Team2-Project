//
//  ContentView.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var selected: Tab = .home

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selected) {
                Group {
                    HomeView()
                        .tag(Tab.home)

        
                    SearchView()
                  
                        .tag(Tab.search)

                    StatisticsView()
                        .tag(Tab.statistic)

                    SettingView()
                        .tag(Tab.setting)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            

            roundedRectTabBar
                .padding(.bottom, verticalSizeClass == .regular ? -5 : -10)
        }
        .ignoresSafeArea(.keyboard)
    }
}

extension ContentView {

    private enum Tab: Hashable {
        case search, home, statistic, setting
    }

    private var roundedRectTabBar: some View {
        HStack {
            Spacer()

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
