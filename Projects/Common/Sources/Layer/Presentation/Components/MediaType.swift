//
//  MediaType.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 5/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public enum MediaType {
    case image
    case video
    
    public var title: String {
        switch self {
        case .image:
            return "이미지"
        case .video:
            return "비디오"
        }
    }
}
