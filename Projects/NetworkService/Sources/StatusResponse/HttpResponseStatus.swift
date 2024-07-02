//
//  HttpResponseStatus.swift
//  NetworkService
//
//  Created by 최동호 on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

enum HttpResponseStatus {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
}
