//
//  RetrospectiveToolBarItem.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

/// RetrospectiveToolBarItem의 Kind 타입 별칭
/// - Note: 툴바 아이템의 종류(이미지 또는 시스템 심볼)를 정의합니다.
typealias ToolBarKind = RetrospectiveToolBarItem.Kind
/// RetrospectiveToolBarItem의 Configuration 타입 별칭
/// - Note: 툴바 아이템의 크기 및 스타일 설정을 위한 구성 타입입니다.
typealias ToolBarConfiguration = RetrospectiveToolBarItem.Configuration

/// 사용자 지정 네비게이션 바의 툴바 아이템을 나타내는 뷰입니다.
struct RetrospectiveToolBarItem: View {

    /// 툴바 아이템의 종류 (이미지 또는 시스템 심볼)
    private let kind: ToolBarKind
    /// 툴바 아이템의 구성 설정 (크기 및 스타일)
    private let config: ToolBarConfiguration
    /// 툴바 아이템을 클릭했을 때 실행할 액션 클로저입니다.
    private let action: () -> Void

    /// RetrospectiveToolBarItem을 초기화합니다.
    /// - Parameters:
    ///   - kind: 툴바 아이템의 종류 (이미지 또는 시스템 심볼)
    ///   - configuration: 툴바 아이템의 구성 설정 (기본값: 기본 설정)
    ///   - action: 툴바 아이템을 클릭할 때 실행할 클로저입니다.
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
    
    /// 툴바 아이템의 종류를 나타내는 열거형입니다.
    enum Kind {
        /// 사용자 지정 이미지를 사용한 아이템
        case asset(String)
        /// SF 심볼 이미지를 사용한 아이템
        case symbol(String)

        /// 툴바 아이템에 표시될 이미지입니다.
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
    
    /// 툴바 아이템의 구성 설정을 나타내는 구조체입니다.
    struct Configuration {
        /// 기본 구성 설정 (30x30 크기, 시스템 타이틀2 폰트)
        static let `default` = Configuration()

        /// 툴바 아이템의 크기를 지정합니다.
        /// - Note: 아이템의 `Kind`가 `asset`인 경우에만 적용됩니다.
        let buttonSize: CGSize
        /// 툴바 아이템의 시스템 폰트를 지정합니다.
        /// - Note: 아이템의 `Kind`가 `symbol`인 경우에만 적용됩니다.
        let symbolFont: Font
        
        /// 구성 설정을 초기화합니다.
        /// - Parameters:
        ///   - buttonSize: 툴바 아이템의 크기 (기본값: 30x30)
        ///   - symbolFont: 툴바 아이템의 시스템 폰트 (기본값: title2)
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

