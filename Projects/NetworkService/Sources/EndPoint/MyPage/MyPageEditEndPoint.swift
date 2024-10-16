//
//  MyPageEditEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct MyPageEditEndPoint: EndPoint {
    private let request: MyPageEditRequest
        
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/my-page/update"
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] {
        [
            "nickName": request.nickName,
            "schoolData": request.schoolData,
            "snsPlatform": request.snsPlatform,
            "mbti": request.mbti,
            "introduction": request.introduction,
            "questions": request.questions
        ]
    }
    
    public var method: HTTPMethod = .post
    
    public init(
        request: MyPageEditRequest
    ) {
        self.request = request
    }
}
