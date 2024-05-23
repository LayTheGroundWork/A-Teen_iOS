//
//  TeenFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol TeenFactory {
    func makeTeenViewController() -> UIViewController
}

struct TeenFactoryImp: TeenFactory {
    func makeTeenViewController() -> UIViewController {
        let controller = TeenViewController()
        controller.navigationItem.title = "Teen"
        return controller
    }
}
