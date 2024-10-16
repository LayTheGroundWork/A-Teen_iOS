//
//  ReportPopoverViewController.swift
//  ATeen
//
//  Created by phang on 6/1/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

protocol ReportPopoverViewControllerCoordinator: AnyObject {
    func didFinish()
    func didSelectReportButton()
}

final class ReportPopoverViewController: UIViewController {
    var popoverPosition: CGRect
    
    // MARK: - Private properties
    private weak var coordinator: ReportPopoverViewControllerCoordinator?
    
    private var popOverViewHeightAnchor: Constraint?

    private lazy var popoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.layer.borderWidth = 1.0
        view.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        return view
    }()
    
    private lazy var reportButton: UIButton = {
        let button = CustomPopoverButton(imageName: DesignSystemAsset.reportIcon.name,
                                         labelText: AppLocalized.reportButton)
        button.isHidden = true
        return button
    }()
    
    private lazy var blockButton: UIButton = {
        let button = CustomPopoverButton(imageName: DesignSystemAsset.blockIcon.name,
                                         labelText: AppLocalized.blockButton)
        button.isHidden = true
        return button
    }()
    
    init(
        coordinator: ReportPopoverViewControllerCoordinator,
        popoverPosition: CGRect
    ) {
        self.coordinator = coordinator
        self.popoverPosition = popoverPosition
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setupActions()
        setupDismissGesture()
        animation()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.clear
        view.addSubview(popoverView)
        popoverView.addSubview(reportButton)
        popoverView.addSubview(blockButton)
    }
    
    private func configLayout() {
        popoverView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-95)
            make.width.equalTo(144)
            self.popOverViewHeightAnchor = make.height.equalTo(0).constraint

            if popoverPosition.origin.y >= 0 {
                make.bottom.equalToSuperview().offset(-ViewValues.height + popoverPosition.origin.y + popoverPosition.size.height - 48)
            } else {
                make.top.equalToSuperview().offset(popoverPosition.origin.y - 60 + popoverPosition.size.height)
            }
        }
        self.view.layoutIfNeeded()
        
        reportButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(144)
            make.top.equalToSuperview()
        }
        
        blockButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(144)
            make.top.equalTo(reportButton.snp.bottom)
        }
    }
    
    private func setupActions() {
        reportButton.addTarget(self,
                               action: #selector(clickReportButton(_:)),
                               for: .touchUpInside)
        blockButton.addTarget(self,
                               action: #selector(clickBlockButton(_:)),
                               for: .touchUpInside)
    }
    
    private func setupDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissPopover))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func animation() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .showHideTransitionViews) {
            self.popOverViewHeightAnchor?.update(offset: 80)
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.reportButton.isHidden = false
            self.blockButton.isHidden = false
        }
    }
    
    // MARK: - Actions
    @objc private func clickReportButton(_ sender: UIButton) {
        coordinator?.didSelectReportButton()
    }
    
    @objc private func clickBlockButton(_ sender: UIButton) {
        print("차단!")
    }
    
    @objc private func dismissPopover() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .showHideTransitionViews) {
            self.reportButton.isHidden = true
            self.blockButton.isHidden = true
            self.popOverViewHeightAnchor?.update(offset: 0)
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.coordinator?.didFinish()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ReportPopoverViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        return !popoverView.frame.contains(touch.location(in: view))
    }
}

