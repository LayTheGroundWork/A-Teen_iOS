//
//  PhotoAuthService.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Photos
import UIKit

public protocol PhotoAuthService {
    var authorizationStatus: PHAuthorizationStatus { get }
    var isAuthorizationLimited: Bool { get }

    func requestAuthorization(completion: @escaping (Result<Void, NSError>) -> Void)
}

extension PhotoAuthService {
    public var isAuthorizationLimited: Bool {
        authorizationStatus == .limited
    }

    fileprivate func goToSetting() {
        guard
            let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url)
        else { return }
        
        UIApplication.shared.open(url, completionHandler: nil)
    }
}

public final class MyPhotoAuthService: PhotoAuthService {
    public init() { }
    
    public var authorizationStatus: PHAuthorizationStatus {
        PHPhotoLibrary.authorizationStatus(for: .readWrite)
    }
    
    public func requestAuthorization(completion: @escaping (Result<Void, NSError>) -> Void) {
        guard authorizationStatus != .authorized else {
            completion(.success(()))
            return
        }
        
        guard authorizationStatus != .denied else {
            DispatchQueue.main.async {
                self.goToSetting()
            }
            completion(.failure(.init()))
            return
        }
        
        guard authorizationStatus == .notDetermined else {
            completion(.failure(.init()))
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
}

