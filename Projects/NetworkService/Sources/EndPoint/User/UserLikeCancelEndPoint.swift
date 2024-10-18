//
//  UserLikeCancelEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserLikeCancelEndPoint: EndPoint {
    private let request: UserLikeRequest
    
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/user/like-cancel"
    
    public var query: [String : String] {
        [
            "likedId": String(request.id)
        ]
    }
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] = [:]
    public var method: HTTPMethod = .post
    
    public init(
        request: UserLikeRequest
    ) {
        self.request = request
    }
}
