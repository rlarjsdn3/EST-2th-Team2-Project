//
//  NavigationBarHeightPreferenceKey.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

struct NavigationBarHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue()
    }
}
