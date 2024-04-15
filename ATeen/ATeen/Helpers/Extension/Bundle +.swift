//
//  Bundle.swift
//  ATeen
//
//  Created by 노주영 on 4/15/24.
//

import Foundation

extension Bundle {
    var kakaoURL : String? {
        return infoDictionary?["KakaoURL"] as? String
    }
}
