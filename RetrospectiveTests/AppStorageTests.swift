//
//  MyAppStorageTests.swift
//  MyAppStorageTests
//
//  Created by 김건우 on 5/9/25.
//

import SwiftUI
import Testing
@testable import Retrospective

@Suite(.serialized)
class AppStorageTests {

    var testUserDefaultsSuiteName: String { "com.testing.AppStorage" }
    var testUserDefaults: UserDefaults { .init(suiteName: testUserDefaultsSuiteName)! }

    var anotherTestUserDefaultsSuiteName: String { "com.anothrTesting.AppStorage" }
    var anotherTestUserDefaults: UserDefaults { .init(suiteName: anotherTestUserDefaultsSuiteName)! }

    deinit {
        clearUserDefaults()
    }

    private func clearUserDefaults() {
        let keys = testUserDefaults.dictionaryRepresentation().keys
        keys.forEach(testUserDefaults.removeObject(forKey:))
        UserDefaults.standard.removeSuite(named: testUserDefaultsSuiteName)

        let anotherKeys = anotherTestUserDefaults.dictionaryRepresentation().keys
        anotherKeys.forEach(anotherTestUserDefaults.removeObject(forKey:))
        UserDefaults.standard.removeSuite(named: anotherTestUserDefaultsSuiteName)
    }

    @Test(arguments: [10, 100, 1000, 10_000, 100_000])
    func test_AppStorage_shouldRetainGivenInitialIntValue_withKeyPath(_ value: Int) async throws {
        @AppStorage(\.loginCount, store: testUserDefaults) var loginCount: Int = value
        #expect(loginCount == value)
    }

    @Test(arguments: [10, 100, 1000, 10_000, 100_000])
    func test_AppStorage_shouldRetainGivenInitialIntValue_withStorageKey(_ value: Int) async throws {
        let storageKey = AppStorageKey("loginCount", defaultValue: value)
        @AppStorage(storageKey: storageKey, store: testUserDefaults) var loginCount: Int
        #expect(loginCount == value)
    }

    @Test func test_AppStorage_shouldPersistIntValueCorrectly() async throws {
        @AppStorage(\.loginCount, store: testUserDefaults) var loginCount: Int
        #expect(loginCount == 0)
        
        loginCount = 1000
        #expect(loginCount == 1000)
        
        @AppStorage(\.loginCount, store: anotherTestUserDefaults) var anotherLoginCount: Int = 200
        #expect(anotherLoginCount == 200)
        
        anotherLoginCount = 0
        #expect(anotherLoginCount == 0)
    }
    
    @Test(arguments: [12.12, 134.134, 78.654321, 356.975, 0.222])
    func test_AppStorage_shouldRetainGivenInitialDoubleValue_withKeyPath(_ value: Double) async throws {
        @AppStorage(\.volumeLevel, store: testUserDefaults) var volumeLevel: Double = value
        #expect(volumeLevel == value)
    }

    @Test(arguments: [12.12, 134.134, 78.654321, 356.975, 0.222])
    func test_AppStorage_shouldRetainGivenInitialIntValue_withStorageKey(_ value: Double) async throws {
        let storageKey = AppStorageKey("volumeLevel", defaultValue: value)
        @AppStorage(storageKey: storageKey, store: testUserDefaults) var volumeLevel: Double
        #expect(volumeLevel == value)
    }

    @Test func test_AppStorage_shouldPersistDoubleValueCorrectly() async throws {
        @AppStorage(\.volumeLevel, store: testUserDefaults) var volumeLevel: Double
        #expect(volumeLevel == 0.0)
        
        volumeLevel = 21.5
        #expect(volumeLevel == 21.5)
        
        @AppStorage(\.volumeLevel, store: anotherTestUserDefaults) var anotherVolumeLevel: Double = 20.0
        #expect(anotherVolumeLevel == 20.0)
        
        anotherVolumeLevel = 5.5
        #expect(anotherVolumeLevel == 5.5)
    }
    
    @Test(arguments: ["A", "김소월", "KimSowol", "김건우", "rlarjsdn3"])
    func test_AppStorage_shouldRetainGivenInitialStringValue_withKeyPath(_ value: String) async throws {
        @AppStorage(\.username, store: testUserDefaults) var username: String = value
        #expect(username == value)
    }

    @Test(arguments: ["A", "김소월", "KimSowol", "김건우", "rlarjsdn3"])
    func test_AppStorage_shouldRetainGivenInitialStringValue_withStorageKey(_ value: String) async throws {
        let storageKey = AppStorageKey("username", defaultValue: value)
        @AppStorage(storageKey: storageKey, store: testUserDefaults) var username: String
        #expect(username == value)
    }

    @Test func test_AppStorage_shouldPersistStringValueCorrectly() async throws {
        @AppStorage(\.username, store: testUserDefaults) var username: String
        #expect(username == "")
        
        username = "김소월"
        #expect(username == "김소월")
        
        @AppStorage(\.username, store: anotherTestUserDefaults) var anotherUsername: String = "흰둥이"
        #expect(anotherUsername == "흰둥이")
        
        anotherUsername = "제주 감귤 돌문어"
        #expect(anotherUsername == "제주 감귤 돌문어")
    }
    
    @Test(arguments: [true, false])
    func test_AppStorage_shouldRetainGivenIntialBooleanValue_withKeyPath(_ value: Bool) async throws {
        @AppStorage(\.isDarkMode, store: testUserDefaults) var isDarkMode: Bool = value
        #expect(isDarkMode == value)
    }

    @Test(arguments: [true, false])
    func test_AppStorage_shouldRetainGivenInitialBooleanValue_withStorageKey(_ value: Bool) async throws {
        let storageKey = AppStorageKey("isDarkMode", defaultValue: value)
        @AppStorage(storageKey: storageKey, store: testUserDefaults) var isDarkMode: Bool
        #expect(isDarkMode == value)
    }

    @Test func test_AppStorage_shouldPersistBooleanValueCorrectly() async throws {
        @AppStorage(\.isDarkMode, store: testUserDefaults) var isDarkMode: Bool
        #expect(isDarkMode == false)
        
        isDarkMode = true
        #expect(isDarkMode == true)
        
        @AppStorage(\.isDarkMode, store: anotherTestUserDefaults) var anotherIsDarkMode: Bool = true
        #expect(anotherIsDarkMode == true)
        
        anotherIsDarkMode = false
        #expect(anotherIsDarkMode == false)
    }
}

fileprivate extension AppStorageKeys {
    var loginCount: AppStorageKey<Int> { .init("loginCount", defaultValue: 0) }
    var volumeLevel: AppStorageKey<Double> { .init("volumeLevel", defaultValue: 0.0) }
    var username: AppStorageKey<String> { .init("username", defaultValue: "") }
    var isDarkMode: AppStorageKey<Bool> { .init("isDarkMode", defaultValue: false) }
}
