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
    /// 앱 첫 실행 시 초기 데이터를 로드했는지 여부를 나타내는 저장 키입니다.
    var hasLoadedInitialData: AppStorageKey<Bool> {
        .init("hasLoadedInitialData_v1", defaultValue: false)
    }
    /// 앱 첫 실행 시 온보딩을 완료했는지 여부를 나타내는 저장 키입니다.
    var hasCompletedOnboarding: AppStorageKey<Bool> {
        .init("hasCompletedOnboarding_v1", defaultValue: false)
    }
}
