//
//  SpinnerDisplayable.swift
//  Common
//
//  Created by 최동호 on 7/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit
import UIKit

protocol SpinnerDisplayable: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension SpinnerDisplayable where Self : UIViewController {
    func showSpinner() {
        guard doesNotExistAnotherSpinner else { return }
        configureSpinner()
    }
    
    private func configureSpinner() {
        let containerView = UIView()
        containerView.tag = ViewValues.tagIdentifierSpinner
        parentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.backgroundColor = .black.withAlphaComponent(ViewValues.opacityContainerSpinner)
        addSpinnerIndicatorToContainer(containerView: containerView)
        
    }
    
    private func addSpinnerIndicatorToContainer(containerView: UIView) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        containerView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func hideSpinner() {
        if let foundView = parentView.viewWithTag(ViewValues.tagIdentifierSpinner) {
            foundView.removeFromSuperview()
        }
    }
    
    private var doesNotExistAnotherSpinner: Bool {
        parentView.viewWithTag(ViewValues.tagIdentifierSpinner) == nil
    }
    
    private var parentView: UIView {
        navigationController?.view ?? view
    }
}
