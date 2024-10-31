//
//  AssetInfo.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 6/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Photos
import UIKit

public struct AssetInfo {
    let phAsset: PHAsset
    let image: UIImage?
    let avAsset: AVAsset?
    let avAudio: AVAudioMix?
    
    public init(
        phAsset: PHAsset,
        image: UIImage?,
        avAsset: AVAsset?,
        avAudio: AVAudioMix?
    ) {
        self.phAsset = phAsset
        self.image = image
        self.avAsset = avAsset
        self.avAudio = avAudio
    }
}
