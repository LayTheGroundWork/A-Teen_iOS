//
//  PostDetailFactoryImp.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

struct PostDetailFactoryImp: PostDetailFactory {
    private(set) var id: Int
    
    func makePostDetailViewController(coordinator: PostDetailViewControllerCoordinator) -> UIViewController {
        let controller = PostDetailViewController(coordinator: coordinator)
        controller.title = "Post #\(id)"
        return controller
    }
    
    func makePhotosViewController() -> UIViewController {
        makeExampleViewController(title: "photos")
    }
    
    func makeMoreDetailViewController() -> UIViewController {
        makeExampleViewController(title: "more detail")
    }
    
    func makeSourceViewController() -> UIViewController {
        makeExampleViewController(title: "source")
    }
    
    private func makeExampleViewController(title: String) -> UIViewController {
        let controller = ExampleViewController()
        controller.title = title
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }
}