
import XCTest
@testable import Le_Baluchon

class TranslateLoaderTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_GivenData_WhenSendRequest() {
        let data = TranslateData().data
        let client = ClientStub(result: .success((data, HTTPURLResponse(url: URL(string: "https://www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none)!)))
        let sut = TranslateLoader(client: client)
       
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(text: "Salut, j'aime le chocolat.") { result in
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
        let error = NetworkError.undecodableData
        let client = ClientStub(result: .failure(error))
        let sut = TranslateLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(text: "Salut, j'aime le chocolat.") { result in
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
        let sut = TranslateLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(text: "Salut, j'aime le chocolat.") { result in
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
    
    class TranslateData {
        var data: Data {
            let bundle = Bundle(for: TranslateLoaderTest.self)
            let url = bundle.url(forResource: "Translate", withExtension: "json")
            let TranslateData = try! Data(contentsOf: url!)
            return TranslateData
        }
    }
    
}
