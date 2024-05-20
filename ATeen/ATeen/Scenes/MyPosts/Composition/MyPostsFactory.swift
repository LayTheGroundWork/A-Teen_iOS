//
//  MyPostsFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

protocol MyPostsFactory {
    func makeMyPostViewController(coordinator: MyPostsViewControllerCoordinator) -> UIViewController
    func makeItemTabBar(navigation: Navigation)
    func makeNewPostViewController(coordinator: NewPostViewControllerCoordinator) -> UIViewController
    func makePostDetailCoordinator(navigation: Navigation, id: Int, parentCoordinator: ParentCoordinator) -> Coordinator
}

struct MyPostsFactoryImp: MyPostsFactory{
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
    
    func makeItemTabBar(navigation: Navigation) {
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
    
    func makePostDetailCoordinator(navigation: Navigation, id: Int, parentCoordinator: ParentCoordinator) -> Coordinator {
        let factory = PostDetailFactoryImp(id: id)
        let coordinator = PostDetailCoordinator(
            navigation: navigation,
            factory: factory,
            parentCoordinator: parentCoordinator)
        return coordinator
    }
}

extension MyPostsFactoryImp: ItemTabFactory { }
