//
//  EndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public enum Scheme: String {
    case http, https
}

public protocol EndPoint {
    var port: String { get }
    var path: String { get }
    var query: [String: String] { get }
    var header: [String: String] { get }
    var body: [String: Any] { get }
    var method: HTTPMethod { get }
}

extension EndPoint {
    public var scheme: Scheme {
        .http
    }
    
    public var host: String {
        Bundle.main.object(forInfoDictionaryKey: "HOST_VALUE") as? String ?? ""
    }
    
    public var toURLRequest: URLRequest? {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = scheme.rawValue
        urlComponent.host = host
        urlComponent.port = Int(port)
        urlComponent.path = path
        
        if !query.isEmpty {
            if query is [String: [String]] {
                
            } else {
                urlComponent.queryItems = query.map {
                    .init(name: $0.key, value: $0.value)
                }
            }
            
            print("urlComponent.queryItems: \(urlComponent.queryItems)")
        }
        
        guard let urlStr = urlComponent.url?.absoluteString,
              let url = URL(string: urlStr) else {
            print("실패 / 현재 urlComponent: \(urlComponent)")
            return nil
        }
        print(urlStr)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.toString
        urlRequest.allHTTPHeaderFields = header
        
        if !body.isEmpty {
            urlRequest.httpBody = encodeBody(body: body)
            print(String(data: urlRequest.httpBody!, encoding: .utf8) ?? "Encoding failed")
        }
        
        return urlRequest
    }
    
    private func encodeBody(body: [String: Any]) -> Data? {
        var encodableBody: [String: AnyEncodable] = [:]
        
        for (key, value) in body {
            encodableBody[key] = AnyEncodable(value)
        }

        do {
            let jsonData = try JSONEncoder().encode(encodableBody)
            return jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            return nil
        }
    }
}

struct AnyEncodable: Encodable {
    var value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case let intValue as Int:
            try container.encode(intValue)
        case let stringValue as String:
            try container.encode(stringValue)
        case let doubleValue as Double:
            try container.encode(doubleValue)
        case let boolValue as Bool:
            try container.encode(boolValue)
        case let arrayValue as [Any]:
            try container.encode(arrayValue.map { AnyEncodable($0) })
        case let dictionaryValue as [String: Any]:
            try container.encode(dictionaryValue.mapValues { AnyEncodable($0) })
        case let customValue as Encodable: // 사용자 정의 타입 처리
            try container.encode(customValue)
        default:
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unsupported value"))
        }
    }
}
