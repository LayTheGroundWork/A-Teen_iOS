//
//  RankingFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

public protocol RankingFactory {
    func makeRankingViewController() -> UIViewController
}

public struct RankingFactoryImp: RankingFactory {
    
    public init() { }
    public func makeRankingViewController() -> UIViewController {
        let controller = RankingViewController()
        controller.navigationItem.title = "Ranking"
        return controller
    }
}
