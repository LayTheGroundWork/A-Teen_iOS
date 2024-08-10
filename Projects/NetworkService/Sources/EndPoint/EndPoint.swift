//
//  EndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

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
        Bundle.main.object(forInfoDictionaryKey: "HOST_VALUE") as? String ?? .empty
    }
    
    public var toURLRequest: URLRequest? {
        var urlComponent = URLComponents()
 
        urlComponent.scheme = scheme.rawValue
        urlComponent.host = host
        urlComponent.port = Int(port)
        urlComponent.path = path
        
        if !query.isEmpty {
            urlComponent.queryItems = query.map {
                .init(name: $0.key, value: $0.value)
            }
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
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: body)
                urlRequest.httpBody = httpBody
            } catch {
                print("body 오류: \(error.localizedDescription)")
            }
        }
        
        print(body)
        print(urlRequest.httpBody as Any)
        
        return urlRequest
    }
}
