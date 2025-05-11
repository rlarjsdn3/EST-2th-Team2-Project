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
        saveChanges()
    }

    /// mainContext에 모델을 삭제한 후, 곧바로 저장합니다.
    ///
    /// - Note: 저장에 실패할 경우, 디버그 콘솔에 오류 로그가 출력되며, 크래시는 일어나지 않습니다.
    /// - Parameter model: 삭제할 모델 객체
    func delete<T>(andSave model: T) where T: PersistentModel {
        delete(model)
        saveChanges()
    }

    private func saveChanges() {
        do {
            try save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

