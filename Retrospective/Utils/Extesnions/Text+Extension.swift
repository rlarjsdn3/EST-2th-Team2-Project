//
//  Text+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/14/25.
//

import SwiftUI

extension Text {

    /// 지정된 형식(format)과 인수를 사용하여 Text 인스턴스를 생성합니다.
    /// - Parameters:
    ///   - format: 포맷 문자열입니다. (예: "Hello, %@!")
    ///   - arguments: 포맷 문자열에 전달할 인수 목록입니다. (CVarArg)
    init(format: String, _ arguments: any CVarArg...) {
        self.init(String(format: format, arguments: arguments))
    }
}
