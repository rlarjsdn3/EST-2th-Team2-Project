//
//  Task+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import Foundation

extension Task where Error == Failure {
    
    /// 지정된 시간 후에 비동기 작업을 지연 실행하는 함수입니다.
    /// - Parameters:
    ///   - timeInterval: 작업을 지연시킬 시간입니다. (초 단위)
    ///   - priority: 작업의 우선 순위입니다.
    ///   - operation: 지정된 시간이 경과한 후 실행할 비동기 작업입니다.
    static func delayed(
        byTimeInterval timeInterval: TimeInterval,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture operation: @Sendable @escaping @isolated(any) () async throws -> Success
    ) {
       Task {
            let seconds = UInt64(timeInterval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: seconds)
            return try await operation()
        }
    }
}
