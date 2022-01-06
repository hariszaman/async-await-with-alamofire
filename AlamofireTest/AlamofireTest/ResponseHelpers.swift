//
//  ResponseHelpers.swift
//  AlamofireTest
//
//  Created by Haris Zaman on 1/4/22.
//

import Foundation
import Alamofire

let headers: HTTPHeaders = [
    "Accept": "application/json"
]

let geturlString = "https://httpbin.org/json"
let postUrlString = "https://httpbin.org/post"

// MARK: - Welcome
struct Welcome: Codable {
    let slideshow: Slideshow
}

// MARK: - Slideshow
struct Slideshow: Codable {
    let author, date: String
    let slides: [Slide]
    let title: String
}

// MARK: - Slide
struct Slide: Codable {
    let title, type: String
    let items: [String]?
}


import Foundation

// MARK: - Welcome
struct PostResponse: Codable {
    let args: Args
    let data: String
    let files, form: Args
    let headers: Headers
    let welcomeJSON: JSONNull?
    let origin: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case args, data, files, form, headers
        case welcomeJSON = "json"
        case origin, url
    }
}

// MARK: - Args
struct Args: Codable {
}

// MARK: - Headers
struct Headers: Codable {
    let accept, acceptEncoding, acceptLanguage, contentLength: String
    let host: String
    let origin, referer: String?
    let secChUa, secChUaMobile, secChUaPlatform, secFetchDest: String?
    let secFetchMode, secFetchSite, userAgent, xAmznTraceID: String?
    
    enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case acceptLanguage = "Accept-Language"
        case contentLength = "Content-Length"
        case host = "Host"
        case origin = "Origin"
        case referer = "Referer"
        case secChUa = "Sec-Ch-Ua"
        case secChUaMobile = "Sec-Ch-Ua-Mobile"
        case secChUaPlatform = "Sec-Ch-Ua-Platform"
        case secFetchDest = "Sec-Fetch-Dest"
        case secFetchMode = "Sec-Fetch-Mode"
        case secFetchSite = "Sec-Fetch-Site"
        case userAgent = "User-Agent"
        case xAmznTraceID = "X-Amzn-Trace-Id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
