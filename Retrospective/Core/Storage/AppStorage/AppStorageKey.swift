//
//  AppStorageKey.swift
//  MyAppStorage
//
//  Created by 김건우 on 5/9/25.
//

import Foundation

/// AppStorageKey는 AppStorage에서 사용할 키와 기본값을 정의하는 구조체입니다.
/// AppStorage에서 키 값과 기본값을 안전하게 관리할 수 있도록 도와줍니다.
struct AppStorageKey<Value> {
    /// AppStorage에서 사용할 키 이름입니다.
    let name: String
    /// AppStorage의 기본값입니다.
    let defaultValue: Value

    /// 지정된 키 이름과 기본값으로 AppStorageKey를 초기화합니다.
    /// - Parameters:
    ///   - name: AppStorage에서 사용할 키 이름
    ///   - defaultValue: AppStorage의 기본값
    init(_ name: String, defaultValue: Value) {
        self.name = name
        self.defaultValue = defaultValue
    }
}
