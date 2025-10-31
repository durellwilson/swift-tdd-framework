import Foundation

/// Protocol for mockable services
public protocol Mockable {
    associatedtype MockType
    static func mock() -> MockType
}

/// Mock network service
public actor MockNetworkService {
    public var responses: [URL: Result<Data, Error>] = [:]
    public var callCount: [URL: Int] = [:]
    
    public init() {}
    
    public func stub(url: URL, response: Result<Data, Error>) {
        responses[url] = response
    }
    
    public func fetch(from url: URL) async throws -> Data {
        callCount[url, default: 0] += 1
        
        guard let response = responses[url] else {
            throw MockError.noStub
        }
        
        switch response {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    public func callCount(for url: URL) -> Int {
        callCount[url] ?? 0
    }
}

public enum MockError: Error {
    case noStub
}
