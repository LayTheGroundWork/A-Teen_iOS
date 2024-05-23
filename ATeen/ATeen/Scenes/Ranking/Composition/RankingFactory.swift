//
//  RankingFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol RankingFactory {
    func makeRankingViewController() -> UIViewController
}

struct RankingFactoryImp: RankingFactory {
    func makeRankingViewController() -> UIViewController {
        let controller = RankingViewController()
        controller.navigationItem.title = "Ranking"
        return controller
    }
}
