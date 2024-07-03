//
//  Album.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 6/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Photos

public struct Album {
    let name: String
    let album: PHFetchResult<PHAsset>
    
    public init(fetchResult: PHFetchResult<PHAsset>, albumName: String) {
        name = albumName
        album = fetchResult
    }
}
