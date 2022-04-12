// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    var items: [Items?]
}

struct Items: Identifiable, Decodable {
    var id: String? {
        self.summary
    }
    var summary: String?
    var start: Start?
    var end: End?
    enum CodingKeys: String, CodingKey {
        case summary
        case start
        case end
    }
}

struct Start: Decodable {
    var dateTime: String?
    var timeZone: String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime
        case timeZone
    }
}

struct End: Decodable {
    var dateTime: String?
    var timeZone: String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime
        case timeZone
    }
}
