//
//  ApiError.swift
//  NetworkService
//
//  Created by 최동호 on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public enum ApiError: Error {
    case clientError
    case serverError
    case unknownError
    case errorInUrl
    case errorDecoding
    case existedUserError
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("클라이언트 오류", comment: "")
        case .serverError:
            return NSLocalizedString("서버 오류", comment: "")
        case .unknownError:
            return NSLocalizedString("알 수 없는 오류", comment: "")
        case .errorInUrl:
            return NSLocalizedString("잘못된 URL", comment: "")
        case .errorDecoding:
            return NSLocalizedString("디코딩 실패", comment: "")

        case .existedUserError:
            return NSLocalizedString("이미 존재하는 계정", comment: "")
        }
    }
}
