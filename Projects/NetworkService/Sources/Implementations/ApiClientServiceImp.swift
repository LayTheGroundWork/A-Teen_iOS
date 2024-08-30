//
//  ApiClientServiceImp.swift
//  NetworkService
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct ApiClientServiceImp: ApiClientService {
    let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func request(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        do {
            let (data: data, request: request) = try await session.data(from: url)
            return (data: data, request: request).data
        } catch {
            return nil
        }
    }
    
    public func request(request: URLRequest) async throws {
        let (_, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknownError
        }
        
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return
        case HttpResponseStatus.existedUser:
            throw ApiError.existedUserError
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    public func request<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T where T : Decodable {
        let (data, response) = try await session.data(for: request)
        return try validateResponse(data: data, response: response)
    }
    
    private func validateResponse<T: Decodable>(
        data: Data,
        response: URLResponse
    ) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknownError
        }
        
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return try decodeModel(data: data)
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    private func decodeModel<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        if let jsonString = String(data: data, encoding: .utf8) {
              print("Raw JSON response: \(jsonString)")
          } else {
              print("Failed to convert data to string.")
          }
          
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
}

