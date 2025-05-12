//
//  TrailingToolBarPreferenceKey.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

/// <#Description#>
struct TrailingToolBarPreferenceKey: PreferenceKey {
    static let defaultValue: ToolBarLayout? = nil

    static func reduce(value: inout ToolBarLayout?, nextValue: () -> ToolBarLayout?) {
        value = nextValue()
    }
}
