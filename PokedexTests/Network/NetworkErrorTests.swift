
import XCTest
@testable import Pokedex

final class NetworkErrorTests: XCTestCase {
    func test_invalidURLEquality() {
        XCTAssertEqual(NetworkError.invalidURL, NetworkError.invalidURL)
    }

    func test_invalidResponseEquality() {
        XCTAssertEqual(NetworkError.invalidResponse, NetworkError.invalidResponse)
    }

    func test_decodingFailedEquality() {
        let error1 = NSError(domain: "Test", code: 1)
        let error2 = NSError(domain: "Test", code: 2)
        XCTAssertEqual(NetworkError.decodingFailed(error1), NetworkError.decodingFailed(error2))
    }
}
