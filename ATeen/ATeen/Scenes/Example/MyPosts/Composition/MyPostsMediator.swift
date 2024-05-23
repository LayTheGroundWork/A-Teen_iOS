//
//  MyPostsMediator.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

protocol MyPostsMediator {
    func updateController(title: String, navigation: Navigation)
}

struct MyPostsMediatorImp: MyPostsMediator {
    func updateController(title: String, navigation: Navigation) {
        guard let myPostViewController = navigation.rootViewController.topViewController as? MyPostsViewController else { return }
        
        myPostViewController.updateLabel(title: title)
    }
}
