
import XCTest
@testable import Le_Baluchon

class WeatherLoaderTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_GivenData_WhenSendRequest() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let client = URLSessionHTTPClient(session: .init(configuration: configuration))
        
    var data: Data {
        let bundle = Bundle(for: WeatherLoaderTest.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let ExchangeData = try! Data(contentsOf: url!)
        return ExchangeData
    }
    
    URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)
    
    let exp = expectation(description: "Waiting for request...")
    
    let loader = WeatherLoader(client: client)
    loader.load(cities: [5128581, 2968815], units: "imperial") { result in
        switch result {
        case let .success(get):
            XCTAssertEqual(get.list[5128581].wind.speed, 15.01)
            XCTAssertEqual(get.list[5128581].main.temp,  68.36)
            XCTAssertEqual(get.list[5128581].main.tempMax, 72.16)
            XCTAssertEqual(get.list[5128581].main.tempMin, 62.22)
            XCTAssertEqual(get.list[5128581].main.humidity, 65)
            XCTAssertEqual(get.list[5128581].weather[0].description, "clear sky")
            XCTAssertEqual(get.list[5128581].weather[0].icon, "01d")
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
        let loader = WeatherLoader(client: client)
        
        let data = "erreur".data(using: .utf8)
        
        URLProtocolStub.stub(data: data, response: HTTPURLResponse(url: URL(string: "www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none), error: .none)
        
        let exp = expectation(description: "Waiting for request...")
        
        loader.load(cities: [5128581, 2968815], units: "imperial") { result in
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
