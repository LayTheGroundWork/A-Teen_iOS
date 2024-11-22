//
//  EditMyPhotoViewModel.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Photos
import UIKit

public final class EditMyPhotoViewModel {
    private let authService = MyPhotoAuthService()

    var originMyPhotoList: [AlbumType] = [.init(image: nil), .init(image: nil)]
    var myPhotoList: [AlbumType] = [.init(image: nil), .init(image: nil)]

    public func extractImageFromVideo(asset: AVAsset, completion: @escaping(UIImage) -> Void) {
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true // 비디오의 회전을 반영

        do {
            // 요청된 시간에서 이미지를 생성
            let cgImage = try imageGenerator.copyCGImage(
                at: CMTime(seconds: 0.0, preferredTimescale: 600),
                actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            completion(image)
        } catch {
            print("Error extracting image: \(error.localizedDescription)")
        }
    }
    
    func addAlbumItem(index: Int, albumType: AlbumType, completion: () -> Void) {
        if myPhotoList.indices.contains(index) {
            myPhotoList[index] = albumType
        } else {
            myPhotoList.append(albumType)
        }
        completion()
    }
    
    func checkEditValue() -> Bool {
        originMyPhotoList != myPhotoList
    }
}
