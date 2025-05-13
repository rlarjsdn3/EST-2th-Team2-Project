//
//  NavigationBarColorPreferenceKey.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

struct NavigationBarColorPreferenceKey: PreferenceKey {
    static let defaultValue: Color? = nil

    static func reduce(value: inout Color?, nextValue: () -> Color?) {
        value = nextValue()
    }
}
