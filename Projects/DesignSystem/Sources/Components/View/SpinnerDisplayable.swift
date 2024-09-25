//
//  SpinnerDisplayable.swift
//  DesignSystem
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit
import Common
import UIKit

public protocol SpinnerDisplayable: AnyObject {
    func showSpinner(color: UIColor)
    func hideSpinner()
}

extension SpinnerDisplayable where Self : UIViewController {
    public func showSpinner(color: UIColor) {
        guard doesNotExistAnotherSpinner else { return }
        configureSpinner(color: color)
    }
    
    private func configureSpinner(color: UIColor) {
        let containerView = UIView()
      

        containerView.tag = ViewValues.tagIdentifierSpinner
        parentView.addSubview(containerView)
    
        containerView.backgroundColor = .black.withAlphaComponent(ViewValues.opacityContainerSpinner)
        
        containerView.snp.updateConstraints() { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        addSpinnerIndicatorToContainer(containerView: containerView, color: color)
    }
    
    private func addSpinnerIndicatorToContainer(containerView: UIView, color: UIColor) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = color
        spinner.startAnimating()
        containerView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func hideSpinner() {
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
