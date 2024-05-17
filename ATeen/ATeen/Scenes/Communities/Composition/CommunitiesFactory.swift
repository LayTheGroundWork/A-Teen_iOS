//
//  CommunitiesFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol CommunitiesFactory {
    func makeMyCommunitiesViewController() -> UIViewController
    func makeItemTabBar(navigation: UINavigationController)
}

struct CommunitiesFactoryImp: CommunitiesFactory {
    func makeMyCommunitiesViewController() -> UIViewController {
        let controller = CommunitiesViewController()
        controller.navigationItem.title = "Communities 🙋🏻‍♂️"
        return controller
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(
            navigation: navigation,
            title: "Communities",
            image: "person.3",
            selectedImage: "person.3.fill")
    }
}

extension CommunitiesFactoryImp: ItemTabFactory { }
