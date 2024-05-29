//
//  TermsOfUseFactory.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import UIKit

protocol TermsOfUseFactory {
    func makeTermsOfUseViewController(coordinator: TermsOfUseCoordinator) -> UIViewController
}

struct TermsOfUseFactoryImp: TermsOfUseFactory {
    func makeTermsOfUseViewController(coordinator: TermsOfUseCoordinator) -> UIViewController {
        let controller = TermsOfUseViewController()
        return controller
    }
}
