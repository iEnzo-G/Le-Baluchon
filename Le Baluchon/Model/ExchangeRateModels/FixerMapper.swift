import Foundation

// The mapper will be use to decode the answer of API
struct FixerMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> FixerItem {
        guard response.statusCode == 200, let response = try? JSONDecoder().decode(FixerItem.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return response
    }
}
