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
    
    public func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T where T : Decodable {
        guard let url = url else { throw ApiError.errorInUrl }
        return try await makeRequest(url: url)
    }
    
    private func makeRequest<T: Decodable>(url: URL) async throws -> T {
        let request = try await session.data(from: url)
        return try validateResponse(request: request)
    }
    
    private func validateResponse<T: Decodable>(
        request: (data: Data, httpResponse: URLResponse)
    ) throws -> T {
        guard let httpResponse = request.httpResponse as? HTTPURLResponse else {
            throw ApiError.unknownError
        }
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return try decodeModel(data: request.data)
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
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
    
}
