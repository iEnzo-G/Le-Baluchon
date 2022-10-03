
import XCTest
@testable import Le_Baluchon

class URLSessionTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_SuccessResponseWithData_WhenSendARequestToAPI() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        
        let initialData = "data".data(using: .utf8)
        
        URLProtocolStub.stub(data: initialData, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)
        
        // Call API.
        
        let exp = expectation(description: "Waiting for request...")
        
        client.get(url: URLRequest(url: URL(string: "https://www.a-url.com")!)) { result in
            switch result {
            case let .success((data, response)):
                XCTAssertEqual(response.statusCode, 200)
                XCTAssertEqual(response.url, URL(string: "www.a-url.com")!)
                XCTAssertEqual(data, initialData)
            case .failure:
                XCTFail("Test is not valid.")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_SuccessResponseButNoData_WhenSendARequestToAPI() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        
        URLProtocolStub.stub(data: .none, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 400, httpVersion: .none, headerFields: .none), error: NSError(domain: "error", code: 0))
        
        // Call API.
        
        let exp = expectation(description: "Waiting for request...")
        
        client.get(url: URLRequest(url: URL(string: "https://www.a-url.com")!)) { result in
            switch result {
            case .success:
                XCTFail("Test is not valid.")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.noData)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_InvalidResponse_WhenSendARequestToAPI() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        let initialData = "data".data(using: .utf8)
        URLProtocolStub.stub(data: initialData, response: URLResponse(url: URL(string: "www.a-url.com")!, mimeType: .none, expectedContentLength: 0, textEncodingName: .none), error: .none)
        
        // Call API.
        
        let exp = expectation(description: "Waiting for request...")
        
        client.get(url: URLRequest(url: URL(string: "https://www.a-url.com")!)) { result in
            switch result {
            case .success:
                XCTFail("Test is not valid.")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
}
