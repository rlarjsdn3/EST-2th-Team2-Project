//
//  Task+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import Foundation

extension Task where Error == Failure {
    
    /// <#Description#>
    /// - Parameters:
    ///   - timeInterval: <#timeInterval description#>
    ///   - priority: <#priority description#>
    ///   - operation: <#operation description#>
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
