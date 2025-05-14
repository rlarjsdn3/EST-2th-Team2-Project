//
//  AppColors.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI

extension ShapeStyle where Self == Color {

    /// 주요 글자색
    /// - Note: 라이트 모드와 다크 모드에서 시스템 기본 글자색을 사용합니다.
    /// - Light Mode: 기본 시스템 글자색 (검정 또는 어두운 회색)
    /// - Dark Mode: 기본 시스템 글자색 (흰색 또는 밝은 회색)
    static var label: Color {
        .init(UIColor.label)
    }

    /// 주요 포인트 색 (아이콘, 버튼 border 등)
    /// - Light Mode: 밝고 선명한 파란색 (RGB: 66, 143, 222)
    /// - Dark Mode: 짙은 파란색 (RGB: 44, 98, 173)
    static var appBlue: Color {
        .init(
            light: Color(r: 66.0, g: 143.0, b: 222.0),
            dark: Color(r: 44.0, g: 98.0, b: 173.0)
        )
    }

    /// 전체 앱 배경색 (연한 살색 계열)
    /// - Note: 전체 배경색으로 사용되는 색상
    /// - Light Mode: 연한 살색 (RGB: 247, 232, 212)
    /// - Dark Mode: 짙은 회색 (RGB: 32, 32, 32)
    static var appLightPeach: Color {
        .init(
            light: Color(r: 247.0, g: 232.0, b: 212.0),
            dark: Color(r: 32.0, g: 32.0, b: 32.0)
        )
    }

    /// 카드 UI의 제목 배경색 (기본 white 혹은 연베이지)
    /// - Light Mode: 밝은 하늘색 (RGB: 227, 240, 251)
    /// - Dark Mode: 짙은 청록색 (RGB: 52, 74, 101)
    static var appSkyBlue: Color {
        .init(
            light: Color(r: 227.0, g: 240.0, b: 251.0),
            dark: Color(r: 52.0, g: 74.0, b: 101.0)
        )
    }

    /// 카드 테두리 등 경계선
    /// - Note: 주요 UI 요소에 사용되는 파란색
    /// - Light Mode: 연한 하늘색 (RGB: 180, 209, 239)
    /// - Dark Mode: 짙은 청록색 (RGB: 41, 59, 78)
    static var appSkyBlue2: Color {
        .init(
            light: Color(r: 180.0, g: 209.0, b: 239.0),
            dark: Color(r: 41.0, g: 59.0, b: 78.0)
        )
    }

    /// 카드 UI의 배경 (기본 white 혹은 연베이지)
    /// - Light Mode: 매우 연한 하늘색 (RGB: 243, 248, 253)
    /// - Dark Mode: 짙은 블루그레이 (RGB: 30, 40, 54)
    static var appLightSkyBlue: Color {
        .init(
            light: Color(r: 243.0, g: 248.0, b: 253.0),
            dark: Color(r: 30.0, g: 40.0, b: 54.0)
        )
    }

    /// 월/날짜 구분 선 및 글씨색
    /// - Light Mode: 밝은 회색 (RGB: 176, 176, 176)
    /// - Dark Mode: 중간 회색 (RGB: 110, 110, 110)
    static var appLightGray: Color {
        .init(
            light: Color(r: 176.0, g: 176.0, b: 176.0),
            dark: Color(r: 110.0, g: 110.0, b: 110.0)
        )
    }

    @available(*, deprecated, renamed: "appLabel")
    static var appLabel: Color {
        .init(
            light: Color(r: 51.0, g: 51.0, b: 51.0),
            dark: Color(r: 51.0, g: 51.0, b: 51.0)
        )
    }

    @available(*, deprecated, renamed: "secondary")
    static var appSsecondary: Color {
        .init(
            light: Color(r: 136.0, g: 136.0, b: 136.0),
            dark: Color(r: 136.0, g: 136.0, b: 136.0)
        )
    }
}


#Preview {
    Grid {
        GridRow {
            ZStack {
                Color.label
                Text("label")
                    .foregroundStyle(.background)
            }
            .frame(width: 100, height: 100)

            ZStack {
                Color.secondary
                Text("secondary")
                    .foregroundStyle(.background)
            }
            .frame(width: 100, height: 100)

            ZStack {
                Color.appBlue
                Text("appBlue")
                    .foregroundStyle(.background)
            }
            .frame(width: 100, height: 100)
        }

        GridRow {
            ZStack {
                Color.appSkyBlue
                Text("appSkyBlue")
                    .foregroundStyle(.label)
            }
            .frame(width: 100, height: 100)

            ZStack {
                Color.appSkyBlue2
                Text("appSkyBlue2")
                    .foregroundStyle(.label)
            }
            .frame(width: 100, height: 100)

            ZStack {
                Color.appLightSkyBlue
                Text("appLightSkyBlue")
                    .foregroundStyle(.label)
            }
            .frame(width: 100, height: 100)
        }

        GridRow {
            ZStack {
                Color.appLightPeach
                Text("appLightPeach")
                    .foregroundStyle(.label)
            }
            .frame(width: 100, height: 100)

            ZStack {
                Color.appLightGray
                Text("appLightGray")
                    .foregroundStyle(.background)
            }
            .frame(width: 100, height: 100)
        }
    }
    .font(.callout)
}
