
import XCTest
@testable import Le_Baluchon

class FixerLoaderTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_GivenData_WhenSendRequest() {

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))

        var data: Data {
            let bundle = Bundle(for: FixerLoaderTest.self)
            let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")
            let ExchangeData = try! Data(contentsOf: url!)
            return ExchangeData
        }

        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)

        let exp = expectation(description: "Waiting for request...")

        let loader = FixerLoader(client: client)
        loader.load(to: "USD", from: "EUR") { result in
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
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        let loader = FixerLoader(client: client)
        
        let data = "erreur".data(using: .utf8)
        
        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)
        
        let exp = expectation(description: "Waiting for request...")
        
        loader.load(to: "USD", from: "EUR") { result in
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
    
    func test_GivenError_WhenGetAnErrorFromAPI() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        let loader = FixerLoader(client: client)
        
        let data = Data()
        
        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: NetworkError.undecodableData)
        
        let exp = expectation(description: "Waiting for request...")
        
        loader.load(to: "USD", from: "EUR") { result in
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
    
//    func testBlabla() {
//        let client = ClientStub(result: .failure(NSError(domain: "an error", code: 0)))
//        let loader = FixerLoader(client: client)
//    }
    
    class ClientStub: HTTPClient {
        
        let result: Result<(Data, HTTPURLResponse), Error>
        
        init(result: Result<(Data, HTTPURLResponse), Error>) {
            self.result = result
        }
        
        func get(url: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
            completion(result)
        }
    }
    
}
