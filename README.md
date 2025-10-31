# Swift TDD Framework

Test-driven development utilities for Swift and SwiftUI with async/await support.

## 🧪 Features

### Async Testing
- Timeout support
- Task cancellation
- Error handling

### SwiftUI Testing
- View inspection
- Component verification
- State testing

### Mock Helpers
- Network mocking
- Call counting
- Response stubbing

## 📦 Installation

```swift
dependencies: [
    .package(url: "https://github.com/durellwilson/swift-tdd-framework.git", from: "1.0.0")
]
```

## 🚀 Quick Start

### Async Tests

```swift
import XCTest
import SwiftTDDFramework

class MyTests: XCTestCase {
    func testAsync() async throws {
        try await asyncTest(timeout: 5) {
            let result = await myAsyncFunction()
            XCTAssertEqual(result, expected)
        }
    }
}
```

### SwiftUI Tests

```swift
func testView() {
    let view = MyView()
    let inspector = ViewInspector.inspect(view)
    
    XCTAssertTrue(inspector.hasText("Hello"))
    XCTAssertTrue(inspector.hasButton(label: "Submit"))
}
```

### Mock Network

```swift
func testNetworking() async throws {
    let mock = MockNetworkService()
    let url = URL(string: "https://api.example.com")!
    
    // Stub response
    await mock.stub(url: url, response: .success(testData))
    
    // Test
    let data = try await mock.fetch(from: url)
    XCTAssertEqual(data, testData)
    
    // Verify calls
    let count = await mock.callCount(for: url)
    XCTAssertEqual(count, 1)
}
```

## 🎯 TDD Workflow

### 1. Write Test First (Red)
```swift
func testUserLogin() async throws {
    let service = AuthService()
    let result = try await service.login(email: "test@example.com", password: "pass")
    XCTAssertTrue(result.isSuccess)
}
```

### 2. Implement (Green)
```swift
actor AuthService {
    func login(email: String, password: String) async throws -> LoginResult {
        // Implementation
        return LoginResult(isSuccess: true)
    }
}
```

### 3. Refactor
```swift
actor AuthService {
    private let network: NetworkService
    
    func login(email: String, password: String) async throws -> LoginResult {
        let request = LoginRequest(email: email, password: password)
        return try await network.post(request, to: loginURL)
    }
}
```

## 🏗️ Best Practices

### Test Structure
```swift
class FeatureTests: XCTestCase {
    // GIVEN
    var sut: SystemUnderTest!
    
    override func setUp() async throws {
        sut = SystemUnderTest()
    }
    
    // WHEN + THEN
    func testFeature() async throws {
        let result = await sut.performAction()
        XCTAssertEqual(result, expected)
    }
}
```

### Actor Testing
```swift
func testActorIsolation() async throws {
    let actor = MyActor()
    
    await actor.setState("test")
    let state = await actor.getState()
    
    XCTAssertEqual(state, "test")
}
```

### SwiftData Testing
```swift
func testSwiftData() throws {
    let container = ModelContainer.create(for: [Item.self], inMemory: true)
    let context = ModelContext(container)
    
    let item = Item(name: "Test")
    context.insert(item)
    try context.save()
    
    let descriptor = FetchDescriptor<Item>()
    let items = try context.fetch(descriptor)
    
    XCTAssertEqual(items.count, 1)
}
```

## 📊 Coverage

Run tests with coverage:
```bash
swift test --enable-code-coverage
```

Generate report:
```bash
xcrun llvm-cov report .build/debug/SwiftTDDFrameworkPackageTests.xctest/Contents/MacOS/SwiftTDDFrameworkPackageTests
```

## 🤝 Contributing

Part of Detroit's Swift testing initiative!

## 📝 License

MIT License

---

**Test-driven Swift development** ✅
