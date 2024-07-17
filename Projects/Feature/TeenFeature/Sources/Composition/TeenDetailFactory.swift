//
//  TeenDetailFactory.swift
//  TeenFeature
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol TeenDetailFactory {
    func makeTeenDetailViewController() -> UIViewController
}

public struct TeenDetailFactoryImp: TeenDetailFactory {
    public init() { }
    
    public func makeTeenDetailViewController() -> UIViewController {
        let controller = TeenDetailViewController()
        return controller
    }
}
