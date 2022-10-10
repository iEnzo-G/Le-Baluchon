
import XCTest
@testable import Le_Baluchon

class WeatherLoaderTest: XCTestCase {
    
    
    // MARK: - Tests
    
    func test_GivenData_WhenSendRequest() {
        let data = WeatherData().data
        let client = ClientStub(result: .success((data, HTTPURLResponse(url: URL(string: "https://www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none)!)))
        let sut = WeatherLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(cities: [5128581, 2968815], units: "imperial") { result in
            switch result {
            case let .success(get):
                // Ask for 1st city : New York
                XCTAssertEqual(get.list[0].wind.speed, 15.01)
                XCTAssertEqual(get.list[0].main.temp,  68.36)
                XCTAssertEqual(get.list[0].main.tempMax, 72.16)
                XCTAssertEqual(get.list[0].main.tempMin, 62.22)
                XCTAssertEqual(get.list[0].main.humidity, 65)
                XCTAssertEqual(get.list[0].weather[0].description, "clear sky")
                XCTAssertEqual(get.list[0].weather[0].icon, "01d")
            case let .failure(error):
                XCTFail("Error was not expected: \(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_GivenError_WhenGetUndecodableData() {
        let client = ClientStub(result: .failure(NetworkError.undecodableData))
        let sut = WeatherLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(cities: [5128581, 2968815], units: "imperial") { result in
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
    
    func test_GivenUndecodableData_WhenTryJSONDecoder_ThenGetUndecodableDataBack() {
        let data = Data()
        let client = ClientStub(result: .success((data, HTTPURLResponse(url: URL(string: "https://www.a-url.com")!, statusCode: 200, httpVersion: .none, headerFields: .none)!)))
        let sut = WeatherLoader(client: client)
        let exp = expectation(description: "Waiting for request...")
        
        sut.load(cities: [5128581, 2968815], units: "imperial") { result in
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
    
    class WeatherData {
        var data: Data {
            let bundle = Bundle(for: WeatherLoaderTest.self)
            let url = bundle.url(forResource: "Weather", withExtension: "json")
            let ExchangeData = try! Data(contentsOf: url!)
            return ExchangeData
        }
    }
    
}
