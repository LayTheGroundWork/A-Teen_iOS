//
//  MyPostsFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

struct MyPostsFactory: ItemTabFactory{
    func makeMyPostViewController(coordinator: MyPostsViewControllerCoordinator) -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 2)
        
        let controller = MyPostsViewController(
            collectionViewLayout: layout,
            coordinator: coordinator
        )
        
        controller.navigationItem.title = "My Posts 📋"
        
        return controller
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(
            navigation: navigation,
            title: "My Posts",
            image: "list.bullet.rectangle.portrait",
            selectedImage: "list.bullet.rectangle.portrait.fill")
    }
    
    func makeNewPostViewController(coordinator: NewPostViewControllerCoordinator) -> UIViewController {
        let controller = NewPostViewController(coordinator: coordinator)
        return controller
    }
    
    func makePostDetailCoordinator(navigation: UINavigationController, id: Int) -> Coordinator {
        let factory = PostDetailFactoryImp(id: id)
        let coordinator = PostDetailCoordinator(navigation: navigation, factory: factory)
        return coordinator
    }
}
