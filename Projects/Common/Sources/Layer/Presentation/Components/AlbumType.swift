//
//  AlbumType.swift
//  Common
//
//  Created by 노주영 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVFoundation
import UIKit

public struct AlbumType {
    public let image: UIImage?
    public let avAsset: AVAsset?
    
    public init(
        image: UIImage?
    ) {
        self.image = image
        self.avAsset = nil
    }
    
    public init(
        avAsset: AVAsset?
    ) {
        self.image = nil
        self.avAsset = avAsset
    }
}
