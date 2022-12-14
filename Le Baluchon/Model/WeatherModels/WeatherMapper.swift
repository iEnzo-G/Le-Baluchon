import Foundation

// The mapper will be use to decode the answer of API
struct WeatherMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> WeatherItem {
        guard response.statusCode == 200, let response = try? JSONDecoder().decode(WeatherItem.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return response
    }
}

