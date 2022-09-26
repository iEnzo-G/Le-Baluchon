//
//  LeBaluchonTest.swift
//  LeBaluchonTest
//
//  Created by Enzo Gammino on 19/09/2022.
//

import XCTest
@testable import Le_Baluchon

class ExchangeRateTest: XCTestCase {
    
    var loader: FixerLoader!
    var expectation: XCTestExpectation!
    let apiURL = FixerEndpoint.get(to: "USD", from: "EUR").url(baseURL: URL(string: "https://api.apilayer.com/fixer")!)
    
    override func setUp() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [Mock_URLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        loader = FixerLoader(client: URLSessionHTTPClient.init(session: urlSession))
        expectation = expectation(description: "Expectation")
    }
    
    // MARK: - Tests
    
    func testSuccessfulResponse() {
        // Prepare mock response.
        let success = true
        let timestamp = 1661766964
        let base = "EUR"
        let date = "2022-08-29"
        let rates = ["USD": 0.995942]
        let jsonString = """
                                 {
                                     "success": \(success),
                                     "timestamp": \(timestamp),
                                     "base": \(base),
                                     "date": \(date),
                                     "rates": {
                                            \(rates)
                                     }
                                 }
                         """
        let data = jsonString.data(using: .utf8)
        
        Mock_URLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw NetworkError.noData
            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // Call API.
        loader.load(to: "USD", from: "EUR") { [weak self] result in
            switch result {
            case let .succes(get):
                XCTAssertEqual(get.success, success)
                XCTAssertEqual(get.timestamp,  timestamp)
                XCTAssertEqual(get.base, base)
                XCTAssertEqual(get.date, date)
                XCTAssertEqual(get.rates, rates)
            case let .failure(error):
                XCTFail("Error was not expected: \(error)")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    class Mock_URLProtocol: URLProtocol {
        
        override class func canInit(with request: URLRequest) -> Bool {
            // To check if this protocol can handle the given request.
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            // Here you return the canonical version of the request but most of the time you pass the orignal one.
            return request
        }
        
        // 1. Handler to test the request and return mock response.
        static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
        
        override func startLoading() {
            // This is where you create the mock response as per your test case and send it to the URLProtocolClient.
            guard let handler = Mock_URLProtocol.requestHandler else {
                fatalError("Handler is unavailable.")
            }
            
            do {
                // 2. Call handler with received request and capture the tuple of response and data.
                let (response, data) = try handler(request)
                
                // 3. Send received response to the client.
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                
                if let data = data {
                    // 4. Send received data to the client.
                    client?.urlProtocol(self, didLoad: data)
                }
                
                // 5. Notify request has been finished.
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                // 6. Notify received error.
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        
        override func stopLoading() {
            // This is called if the request gets canceled or completed.
        }
    }
}
