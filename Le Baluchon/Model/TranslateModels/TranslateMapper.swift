import Foundation

// The mapper will be use to decode the answer of API
final class TranslateMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> TranslateItem {
        guard response.statusCode == 200, let response = try? JSONDecoder().decode(TranslateItem.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return response
    }
}

