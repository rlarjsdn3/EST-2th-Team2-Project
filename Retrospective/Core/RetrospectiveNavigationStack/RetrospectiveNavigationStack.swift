//
//  RetrospectiveNavigationStack.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

/// 사용자 지정 네비게이션 스택 뷰로, 사용자 정의 툴바 및 네비게이션 타이틀을 설정할 수 있습니다.
/// - Note: 기본 NavigationStack의 네비게이션 바를 사용자 정의 툴바와 타이틀 영역으로 대체합니다.
struct RetrospectiveNavigationStack<Root>: View where Root: View {
    
    /// 사용자 지정 네비게이션 바에 표시될 타이틀입니다.
    @State private var navigationTitle: String? = nil
    /// 사용자 지정 네비게이션 바의 높이를 나타냅니다.
    @State private var navigationBarHeight: CGFloat? = nil
    /// 네비게이션 바의 좌측 툴바 레이아웃을 설정합니다.
    @State private var leadingToolbar: ToolBarLayout? = nil
    /// 네비게이션 바의 우측 툴바 레이아웃을 설정합니다.
    @State private var trailingToolbar: ToolBarLayout? = nil
    /// 사용자 지정 네비게이션 바의 배경색을 설정합니다.
    @State private var navigationBarColor: Color? = nil

    /// 사용자 지정 네비게이션 바 아래에 표시될 루트 콘텐츠 뷰입니다.
    private let root: Root

    /// RetrospectiveNavigationStack을 초기화합니다.
    /// - Parameter root: 네비게이션 스택의 루트 콘텐츠를 반환하는 클로저
    init(root: () -> Root) {
        self.root = root()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                navigationBar

                navigationContent
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden()
        }
        .onPreferenceChangeMainActor(NavigationTitlePreferenceKey.self) { title in
            navigationTitle = title
        }
        .onPreferenceChangeMainActor(LeadingToolBarPreferenceKey.self) { toolbar in
            leadingToolbar = toolbar
        }
        .onPreferenceChangeMainActor(TrailingToolBarPreferenceKey.self) { toolbar in
            trailingToolbar = toolbar
        }
        .onPreferenceChangeMainActor(NavigationBarColorPreferenceKey.self) { color in
            navigationBarColor = color
        }
    }
}

extension RetrospectiveNavigationStack {

    @ViewBuilder
    var navigationBar: some View {
        HStack(spacing: 0) {
            if let leadingToolbar = leadingToolbar {
                HStack(spacing: leadingToolbar.spacing) {
                    leadingToolbar.toolBarProvider
                }
            }
            Spacer()
            if let trailingToolbar = trailingToolbar {
                HStack(spacing: trailingToolbar.spacing) {
                    trailingToolbar.toolBarProvider
                }
            }
        }
        .overlay {
            if let navigationTitle = navigationTitle {
                Text(navigationTitle)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .frame(height: navigationBarHeight ?? 44)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 4)
        .background(navigationBarColor ?? .clear)

        Divider()
    }

    var navigationContent: some View {
        root
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    RetrospectiveNavigationStack {
        Text("Hello, RetrospectiveNavigationStack!")
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) { }
            }
            .retrospectiveTrailingToolbar {
                RetrospectiveToolBarItem(.asset("filter")) { }
            }
            .retrospectiveNavigationTitle("Our Camp Diary")
    }
}

#Preview {
    RetrospectiveNavigationStack {
        VStack {
            ForEach(1...10, id: \.self) { _ in
                Text("Hello, RetrospectiveNavigationStack!")
            }
        }
        .retrospectiveLeadingToolBar {
            RetrospectiveToolBarItem(.symbol("chevron.left")) { }
        }
        .retrospectiveTrailingToolbar {
            RetrospectiveToolBarItem(.asset("filter")) { }
                .padding()
        }
        .retrospectiveNavigationTitle("Our Camp Diary")
        .retrospectiveNavigationBarColor(.appLightPeach)
    }
}

#Preview {
    RetrospectiveNavigationStack {
        VStack {
            ForEach(1...100, id: \.self) { _ in
                Text("Hello, RetrospectiveNavigationStack!")
            }
        }
        .retrospectiveLeadingToolBar {
            RetrospectiveToolBarItem(.symbol("chevron.left")) { }
        }
        .retrospectiveTrailingToolbar {
            RetrospectiveToolBarItem(.asset("filter")) { }
        }
        .retrospectiveNavigationTitle("Our Camp Diary")
    }
}

#Preview {
    RetrospectiveNavigationStack {
        List {
            ForEach(1...100, id: \.self) { _ in
                Text("Hello, RetrospectiveNavigationStack!")
            }
        }
        .retrospectiveLeadingToolBar {
            RetrospectiveToolBarItem(.symbol("chevron.left")) { }
        }
        .retrospectiveTrailingToolbar {
            RetrospectiveToolBarItem(.asset("filter")) { }
        }
        .retrospectiveNavigationTitle("Our Camp Diary")
        .ignoresSafeArea()
    }
}

#Preview {
    RetrospectiveNavigationStack {
        ScrollView {
            ForEach(1...100, id: \.self) { _ in
                Text("Hello, RetrospectiveNavigationStack!")
            }
            .frame(maxWidth: .infinity)
        }
        .retrospectiveLeadingToolBar {
            RetrospectiveToolBarItem(.symbol("chevron.left")) { }
        }
        .retrospectiveTrailingToolbar {
            RetrospectiveToolBarItem(.asset("filter")) { }
        }
        .retrospectiveNavigationTitle("Our Camp Diary")
        .ignoresSafeArea()
    }
}
