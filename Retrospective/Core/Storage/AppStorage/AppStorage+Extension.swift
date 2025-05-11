//
//  AppStorage+Extension.swift
//  MyAppStorage
//
//  Created by 김건우 on 5/9/25.
//

import SwiftUI

extension AppStorage where Value == Int {

    /// AppStorage를 지정된 키 경로로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(wrappedValue: wrappedValue, storageKey: storageKey, store: store)
    }


    /// AppStorage를 지정된 키로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: wrappedValue, storageKey.name, store: store)
    }


    /// 지정된 키 경로로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(storageKey: storageKey, store: store)
    }

    /// 지정된 키로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: storageKey.defaultValue, storageKey: storageKey, store: store)
    }
}

extension AppStorage where Value == Double {

    /// AppStorage를 지정된 키 경로로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(wrappedValue: wrappedValue, storageKey: storageKey, store: store)
    }


    /// AppStorage를 지정된 키로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: wrappedValue, storageKey.name, store: store)
    }


    /// 지정된 키 경로로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(storageKey: storageKey, store: store)
    }

    /// 지정된 키로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: storageKey.defaultValue, storageKey: storageKey, store: store)
    }
}


extension AppStorage where Value == String {

    /// AppStorage를 지정된 키 경로로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(wrappedValue: wrappedValue, storageKey: storageKey, store: store)
    }


    /// AppStorage를 지정된 키로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: wrappedValue, storageKey.name, store: store)
    }


    /// 지정된 키 경로로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(storageKey: storageKey, store: store)
    }

    /// 지정된 키로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: storageKey.defaultValue, storageKey: storageKey, store: store)
    }
}


extension AppStorage where Value == Bool {

    /// AppStorage를 지정된 키 경로로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(wrappedValue: wrappedValue, storageKey: storageKey, store: store)
    }


    /// AppStorage를 지정된 키로 초기화하여 기본값을 설정합니다.
    /// - Parameters:
    ///   - wrappedValue: AppStorage의 초기값으로 사용할 Value
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        wrappedValue: Value,
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: wrappedValue, storageKey.name, store: store)
    }


    /// 지정된 키 경로로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKeyPath: AppStorageKeys에서 사용할 키 경로
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        _ storageKeyPath: KeyPath<AppStorageKeys, AppStorageKey<Value>>,
        store: UserDefaults? = nil
    ) {
        let storageKey = AppStorageKeys()[keyPath: storageKeyPath]
        self.init(storageKey: storageKey, store: store)
    }

    /// 지정된 키로 AppStorage를 초기화하고, `AppStorageKey`의 기본값으로 설정합니다.
    /// - Parameters:
    ///   - storageKey: 사용할 AppStorageKey
    ///   - store: UserDefaults 인스턴스 (기본값: 기본 UserDefaults)
    init(
        storageKey: AppStorageKey<Value>,
        store: UserDefaults? = nil
    ) {
        self.init(wrappedValue: storageKey.defaultValue, storageKey: storageKey, store: store)
    }
}
