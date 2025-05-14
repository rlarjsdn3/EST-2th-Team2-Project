//
//  ModelContext+Extension.swift
//  SwiftDataExample
//
//  Created by 김건우 on 5/12/25.
//

import SwiftData

extension ModelContext {
    
    /// mainContext에 모델을 추가한 후, 곧바로 저장합니다.
    ///
    /// - Note: 저장에 실패할 경우, 디버그 콘솔에 오류 로그가 출력되며, 크래시는 일어나지 않습니다.
    /// - Parameter model: 저장할 모델 객체
    func insert<T>(andSave model: T) where T: PersistentModel {
        insert(model)
        save(onFailure: nil)
    }

    /// mainContext에 모델을 삭제한 후, 곧바로 저장합니다.
    ///
    /// - Note: 저장에 실패할 경우, 디버그 콘솔에 오류 로그가 출력되며, 크래시는 일어나지 않습니다.
    /// - Parameter model: 삭제할 모델 객체
    func delete<T>(andSave model: T) where T: PersistentModel {
        delete(model)
        save(onFailure: nil)
    }

    /// 변경된 컨텍스트를 데이터베이스에 저장합니다.
    ///
    /// - Parameter failure: 저장이 실패할 경우 호출될 클로저입니다.
    /// - Note: 저장 중 에러가 발생하면 해당 에러 메시지가 콘솔에 출력됩니다.
    func save(onFailure failure: (() -> Void)? = nil) {
        do {
            try save()
        } catch {
            failure?()
            print(error.localizedDescription)
        }
    }
}

