//
//  MyPostsMediator.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

protocol MyPostsMediator {
    func updateController(title: String, navigation: UINavigationController)
}

struct MyPostsMediatorImp: MyPostsMediator {
    func updateController(title: String, navigation: UINavigationController) {
        guard let myPostViewController = navigation.topViewController as? MyPostsViewController else { return }
        
        myPostViewController.updateLabel(title: title)
    }
}
