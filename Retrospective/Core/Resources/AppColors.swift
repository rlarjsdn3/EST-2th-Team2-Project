//
//  AppColors.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI

extension ShapeStyle where Self == Color {

    /// 주요 글자색
    /// - Note: 주석 미완성
    static var label: Color {
        .init(UIColor.label)
    }

    /// 주요 포인트 색 (아이콘, 버튼 border 등)
    /// - Note: 주석 미완성
    static var appBlue: Color {
        .init(
            light: Color(r: 66.0, g: 143.0, b: 222.0),
            dark: Color(r: 66.0, g: 143.0, b: 222.0)
        )
    }

    /// 전체 앱 배경색 (연한 살색 계열)
    /// - Note: 주석 미완성
    static var appLightPeach: Color {
        .init(
            light: Color(r: 247.0, g: 232.0, b: 212.0),
            dark: Color(r: 32.0, g: 32.0, b: 32.0)
        )
    }

    /// 카드 UI의 제목 배경색 (기본 white 혹은 연베이지)
    /// - Note: 주석 미완성
    static var appSkyBlue: Color {
        .init(
            light: Color(r: 227.0, g: 240.0, b: 251.0),
            dark: Color(r: 227.0, g: 240.0, b: 251.0)
        )
    }

    /// 카드 테두리 등 경계선
    /// - Note: 주석 미완성
    static var appSkyBlue2: Color {
        .init(
            light: Color(r: 180.0, g: 209.0, b: 239.0),
            dark: Color(r: 180.0, g: 209.0, b: 239.0)
        )
    }

    /// 카드 UI의 배경 (기본 white 혹은 연베이지)
    /// - Note: 주석 미완성
    static var appLightSkyBlue: Color {
        .init(
            light: Color(r: 243.0, g: 248.0, b: 253.0),
            dark: Color(r: 243.0, g: 248.0, b: 253.0)
        )
    }

    /// 월/날짜 구분 선 및 글씨색
    /// - Note: 주석 미완성
    static var appLightGray: Color {
        .init(
            light: Color(r: 176.0, g: 176.0, b: 176.0),
            dark: Color(r: 176.0, g: 176.0, b: 176.0)
        )
    }

    /// 일반 텍스트용 (기본 텍스트)
    /// - Note: 주석 미완성
    @available(*, deprecated, renamed: "appLabel")
    static var appLabel: Color {
        .init(
            light: Color(r: 51.0, g: 51.0, b: 51.0),
            dark: Color(r: 51.0, g: 51.0, b: 51.0)
        )
    }

    /// 안눌린 버튼 등
    /// - Note: 주석 미완성
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
