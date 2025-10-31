import XCTest
import SwiftUI

/// Async test helper
public func asyncTest(
    timeout: TimeInterval = 5,
    _ block: @escaping () async throws -> Void
) async throws {
    try await withTimeout(timeout) {
        try await block()
    }
}

public func withTimeout<T>(
    _ timeout: TimeInterval,
    _ operation: @escaping () async throws -> T
) async throws -> T {
    try await withThrowingTaskGroup(of: T.self) { group in
        group.addTask {
            try await operation()
        }
        
        group.addTask {
            try await Task.sleep(for: .seconds(timeout))
            throw TestError.timeout
        }
        
        guard let result = try await group.next() else {
            throw TestError.noResult
        }
        group.cancelAll()
        return result
    }
}

public enum TestError: Error {
    case timeout
    case noResult
}
