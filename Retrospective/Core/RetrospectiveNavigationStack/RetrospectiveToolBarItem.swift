//
//  RetrospectiveToolBarItem.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

///
typealias ToolBarKind = RetrospectiveToolBarItem.Kind
///
typealias ToolBarConfiguration = RetrospectiveToolBarItem.Configuration

struct RetrospectiveToolBarItem: View {

    ///
    private let kind: ToolBarKind
    ///
    private let config: ToolBarConfiguration
    /// <#Description#>
    private let action: () -> Void

    /// <#Description#>
    /// - Parameters:
    ///   - kind: <#kind description#>
    ///   - configuration: <#configuration description#>
    ///   - action: <#action description#>
    init(
        _ kind: ToolBarKind,
        configuration: ToolBarConfiguration = .default,
        action: @escaping () -> Void
    ) {
        self.kind = kind
        self.config = configuration
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            switch kind {
            case .asset:
                kind.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: config.buttonSize.width, height: config.buttonSize.height)
            case .symbol:
                kind.image
                    .font(config.symbolFont)
                    .fontWeight(.semibold)
                    .foregroundStyle(.label)
            }
        }
    }
}


extension RetrospectiveToolBarItem {
    
    /// <#Description#>
    enum Kind {
        ///
        case asset(String)
        ///
        case symbol(String)

        ///
        var image: Image {
            switch self {
            case .asset(let string):
                Image(string)
            case .symbol(let string):
                Image(systemName: string)
            }
        }
    }
}

extension RetrospectiveToolBarItem {
    
    /// <#Description#>
    struct Configuration {
        ///
        static let `default` = Configuration()

        ///
        let buttonSize: CGSize
        ///
        let symbolFont: Font
        
        /// <#Description#>
        /// - Parameters:
        ///   - buttonSize: <#buttonSize description#>
        ///   - symbolFont: <#symbolFont description#>
        init(
            buttonSize: CGSize = .init(width: 30, height: 30),
            symbolFont: Font = .title2
        ) {
            self.buttonSize = buttonSize
            self.symbolFont = symbolFont
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RetrospectiveToolBarItem(.asset("filter")) {
        print("trigger button action")
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RetrospectiveToolBarItem(.symbol("chevron.left")) {
        print("trigger button action")
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let config = ToolBarConfiguration(symbolFont: .largeTitle)
    RetrospectiveToolBarItem(.symbol("chevron.left"), configuration: config) {
        print("trigger button action")
    }
}

