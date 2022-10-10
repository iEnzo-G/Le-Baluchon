
import XCTest
@testable import Le_Baluchon

class FixerLoaderTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_GivenData_WhenSendRequest() {
        let exp = expectation(description: "Waiting for request...")
        let data = FixerData().data
        let client = ClientStub(result: .success((data, HTTPURLResponse(url: URL(string: "https://www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none)!)))
        let sut = FixerLoader(client: client)
        
        sut.load(to: "USD", from: "EUR") { result in
            switch result {
            case let .success(get):
                XCTAssertEqual(get.success, true)
                XCTAssertEqual(get.base, "EUR")
                XCTAssertEqual(get.rates["USD"], 0.995942)
            case let .failure(error):
                XCTFail("Error was not expected: \(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_GivenError_WhenGetInvalidData() {
        let error = NetworkError.undecodableData
        let client = ClientStub(result: .failure(error))
        let sut = FixerLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(to: "USD", from: "EUR") { result in
            switch result {
            case .success:
                XCTFail("Test is not valid.")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.undecodableData)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_GivenUndecodableData_WhenTryJSONDecoder_ThenGetNetworkError() {
        let data = Data()
        let client = ClientStub(result: .success((data, HTTPURLResponse(url: URL(string: "https://www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none)!)))
        let sut = FixerLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(to: "USD", from: "EUR") { result in
            switch result {
            case .success:
                XCTFail("Test is not valid.")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.undecodableData)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    class FixerData {
        var data: Data {
            let bundle = Bundle(for: FixerLoaderTest.self)
            let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")
            let ExchangeData = try! Data(contentsOf: url!)
            return ExchangeData
        }
    }
}

