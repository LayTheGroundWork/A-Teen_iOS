//
//  ItemTabFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol ItemTabFactory { }

extension ItemTabFactory {
    func makeItemTabBar(
        navigation: Navigation,
        title: String,
        image: String,
        selectedImage: String
    ) {
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(named: image),
            selectedImage: UIImage(named: selectedImage))
        
        navigation.rootViewController.tabBarItem = tabBarItem
    }
}
