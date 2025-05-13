//
//  Text+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

extension Text {

    /// <#Description#>
    /// - Parameters:
    ///   - format: <#format description#>
    ///   - vrage: <#vrage description#>
    init(format: String, _ vrage: any CVarArg...) {
        self.init(String(format: format, arguments: vrage))
    }
}
