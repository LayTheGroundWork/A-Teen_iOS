//
//  BaseViewModel.swift
//  Common
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}

