
import XCTest
@testable import Le_Baluchon

class TranslateLoaderTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_GivenData_WhenSendRequest() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        
        var data: Data {
            let bundle = Bundle(for: TranslateLoaderTest.self)
            let url = bundle.url(forResource: "Translate", withExtension: "json")
            let ExchangeData = try! Data(contentsOf: url!)
            return ExchangeData
        }
        
        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)
         
        let exp = expectation(description: "Waiting for request...")
        
        let loader = TranslateLoader(client: client)
        loader.load(text: "Salut, j'aime le chocolat.") { result in
            switch result {
            case let .success(post):
                XCTAssertEqual(post.translations[0].text, "Hi, I like chocolate.")
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
        let loader = TranslateLoader(client: client)
        
        let data = "erreur".data(using: .utf8)
        
        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)
        
        let exp = expectation(description: "Waiting for request...")
        
        loader.load(text: "Salut, j'aime le chocolat.") { result in
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
        let loader = TranslateLoader(client: client)
        
        let data = Data()
        
        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: NetworkError.undecodableData)
        
        let exp = expectation(description: "Waiting for request...")
        
        loader.load(text: "Salut, j'aime le chocolat.") { result in
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
    

    
}
