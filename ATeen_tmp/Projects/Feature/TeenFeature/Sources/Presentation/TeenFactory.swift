//
//  TeenFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

public protocol TeenFactory {
    func makeTeenViewController() -> UIViewController
}

public struct TeenFactoryImp: TeenFactory {
    
    public init() { }
    
    public func makeTeenViewController() -> UIViewController {
        let controller = TeenViewController()
        controller.navigationItem.title = "Teen"
        return controller
    }
}
