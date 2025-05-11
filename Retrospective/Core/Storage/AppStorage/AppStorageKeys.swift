//
//  AppStorageKeys.swift
//  MyAppStorage
//
//  Created by 김건우 on 5/9/25.
//

import Foundation

struct AppStorageKeys { }

/// 프로젝트 전반에서 사용할 AppStorageKey를 정의하는 확장입니다.
extension AppStorageKeys {
    var example: AppStorageKey<Bool> { .init("example", defaultValue: true) }
}
