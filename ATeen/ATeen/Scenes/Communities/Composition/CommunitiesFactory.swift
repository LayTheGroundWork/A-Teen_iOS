//
//  CommunitiesFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol CommunitiesFactory {
    func makeMyCommunitiesViewController() -> UIViewController
    func makeItemTabBar(navigation: Navigation)
}

struct CommunitiesFactoryImp: CommunitiesFactory {
    func makeMyCommunitiesViewController() -> UIViewController {
        let controller = CommunitiesViewController()
        controller.navigationItem.title = "Communities 🙋🏻‍♂️"
        return controller
    }
    
    func makeItemTabBar(navigation: Navigation) {
        makeItemTabBar(
            navigation: navigation,
            title: "Teen",
            image: "teenIcon",
            selectedImage: "teenIconSelected")
    }
}

extension CommunitiesFactoryImp: ItemTabFactory { }
