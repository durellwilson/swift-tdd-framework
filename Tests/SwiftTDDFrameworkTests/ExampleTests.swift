import XCTest
@testable import SwiftTDDFramework

final class ExampleTests: XCTestCase {
    func testAsyncOperation() async throws {
        try await asyncTest {
            let result = await performAsyncOperation()
            XCTAssertEqual(result, "success")
        }
    }
    
    func testMockNetwork() async throws {
        let mock = MockNetworkService()
        let url = URL(string: "https://api.example.com")!
        let testData = "test".data(using: .utf8)!
        
        await mock.stub(url: url, response: .success(testData))
        
        let data = try await mock.fetch(from: url)
        XCTAssertEqual(data, testData)
        
        let count = await mock.callCount(for: url)
        XCTAssertEqual(count, 1)
    }
    
    private func performAsyncOperation() async -> String {
        try? await Task.sleep(for: .milliseconds(100))
        return "success"
    }
}
