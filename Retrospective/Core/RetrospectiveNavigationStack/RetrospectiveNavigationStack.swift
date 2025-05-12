//
//  RetrospectiveNavigationStack.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

/// <#Description#>
struct RetrospectiveNavigationStack<Root>: View where Root: View {

    @State private var navigationTitle: String? = nil
    @State private var navigationBarHeight: CGFloat? = nil
    @State private var leadingToolbar: ToolBarLayout? = nil
    @State private var trailingToolbar: ToolBarLayout? = nil

    /// <#Description#>
    private let root: Root

    /// <#Description#>
    /// - Parameter root: <#root description#>
    init(root: () -> Root) {
        self.root = root()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
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
                .background(.white)

                Divider()

                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                    root
                    Spacer(minLength: 0)
                }
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden()
        }

        .onPreferenceChangeOnMainActor(NavigationTitlePreferenceKey.self) { title in
            navigationTitle = title
        }
        .onPreferenceChangeOnMainActor(LeadingToolBarPreferenceKey.self) { toolbar in
            leadingToolbar = toolbar
        }
        .onPreferenceChangeOnMainActor(TrailingToolBarPreferenceKey.self) { toolbar in
            trailingToolbar = toolbar
        }
    }
}

extension View {

    /// <#Description#>
    /// - Parameter title: <#title description#>
    /// - Returns: <#description#>
    func retrospectiveNavigationTitle(_ title: String) -> some View {
        self.preference(key: NavigationTitlePreferenceKey.self, value: title)
    }


    /// <#Description#>
    /// - Parameters:
    ///   - spacing: <#spacing description#>
    ///   - content: <#content description#>
    /// - Returns: <#description#>
    func retrospectiveLeadingToolBar(
        spacing: CGFloat = 10,
        @ViewBuilder _ content: @escaping () -> some View
    ) -> some View {
        self.preference(
            key: LeadingToolBarPreferenceKey.self,
            value: ToolBarLayout(spacing: spacing, toolBarProvider: AnyView(content()))
        )
    }

    /// <#Description#>
    /// - Parameters:
    ///   - spacing: <#spacing description#>
    ///   - content: <#content description#>
    /// - Returns: <#description#>
    func retrospectiveTrailingToolbar(
        spacing: CGFloat = 10,
        @ViewBuilder _ content: @escaping () -> some View
    ) -> some View {
        self.preference(
            key: TrailingToolBarPreferenceKey.self,
            value: ToolBarLayout(spacing: spacing, toolBarProvider: AnyView(content()))
        )
    }
}


extension View {

    /// <#Description#>
    /// - Parameters:
    ///   - key: <#key description#>
    ///   - action: <#action description#>
    /// - Returns: <#description#>
    func onPreferenceChangeOnMainActor<K>(
        _ key: K.Type = K.self,
        perform action: @escaping (K.Value) -> Void
    ) -> some View where K: PreferenceKey, K.Value: Equatable {
        self.onPreferenceChange(key) { value in
            Task { @MainActor in
                action(value)
            }
        }
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
        }
        .retrospectiveNavigationTitle("Our Camp Diary")
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
