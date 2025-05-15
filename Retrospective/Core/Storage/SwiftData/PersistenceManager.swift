//
//  PersistenceManager.swift
//  SwiftDataExample
//
//  Created by 김건우 on 5/12/25.
//

import SwiftData

@MainActor
final class PersistenceManager {

    /// 모델 데이터를 가져오거나, 수정하거나 삭제할 수 있는 메인 컨텍스트 객체입니다.
    /// - Note: 이 컨텍스트는 ModelContainer의 기본 컨텍스트로,
    ///   모든 데이터 작업은 이 컨텍스트를 통해 수행됩니다.
    var mainContext: ModelContext {
        container.mainContext
    }

    private let container: ModelContainer = {
        let schema = Schema([
            Diary.self, Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }()


    func createInitialCategories(completion: (() -> Void)? = nil) {
        let categories = [Category(name: "카테고리 1", color: .red),
                          Category(name: "카테고리 2", color: .blue),
                          Category(name: "카테고리 3", color: .yellow),
                          Category(name: "카테고리 4", color: .green),
                          Category(name: "카테고리 5", color: .black)]
        categories.forEach(mainContext.insert(andSave:))
        completion?()
    }
}

extension PersistenceManager {
    
    /// 프리뷰 환경에서만 사용되는 ModelContainer 객체입니다.
    /// 이 컨테이너는 메모리에만 저장되는 임시 컨테이너입니다.
    /// - Note: 각 모델에 대한 Mock 데이터가 포함되어 있어,
    /// Preview에서 실제 데이터 없이도 UI를 미리볼 수 있습니다.
    static let previewContainer: ModelContainer = {
        let schema = Schema([
            Diary.self, Category.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        do {
            let container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )

            Diary.mock.forEach(container.mainContext.insert(_:))

            return container
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
}
