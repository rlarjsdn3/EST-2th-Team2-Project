//
//  NavigationTitlePreferenceKey.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

/// <#Description#>
struct NavigationTitlePreferenceKey: PreferenceKey {
    static let defaultValue: String? = nil

    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}
