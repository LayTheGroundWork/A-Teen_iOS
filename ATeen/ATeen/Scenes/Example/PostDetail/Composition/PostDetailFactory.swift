//
//  PostDetailFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

protocol PostDetailFactory {
    func makePostDetailViewController(coordinator: PostDetailViewControllerCoordinator) -> UIViewController
    func makePhotosViewController() -> UIViewController
    func makeMoreDetailViewController() -> UIViewController
    func makeSourceViewController() -> UIViewController
}

