//
//  SchoolDataEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SchoolDataEndPoint: EndPoint {
    private let request: SchoolDataRequest
    
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/schools"
    
    public var query: [String : String] {
        [
            "schoolName": request.schoolName
        ]
    }
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
    public var method: HTTPMethod = .get
    
    public init(
        request: SchoolDataRequest
    ) {
        self.request = request
   
    }
}
