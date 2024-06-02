//
//  ReportPopoverViewController.swift
//  ATeen
//
//  Created by phang on 6/1/24.
//

import SnapKit

import UIKit

protocol ReportPopoverViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class ReportPopoverViewController: UIViewController {
    var popoverPosition: CGRect
    
    // MARK: - Private properties
    private weak var coordinator: ReportPopoverViewControllerCoordinator?

    private lazy var popoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var reportButton: UIButton = {
        let button = CustomPopoverButton(imageName: "reportIcon",
                                         labelText: "신고하기")
        return button
    }()
    
    private lazy var blockButton: UIButton = {
        let button = CustomPopoverButton(imageName: "blockIcon",
                                         labelText: "차단하기")
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
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .clear
        view.addSubview(popoverView)
        popoverView.addSubview(reportButton)
        popoverView.addSubview(blockButton)
    }
    
    private func configLayout() {
        popoverView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-95)
            if popoverPosition.origin.y >= ViewValues.height / 2 {
                make.top.equalToSuperview().offset(popoverPosition.origin.y - 80 + popoverPosition.size.height / 2)
            } else {
                make.top.equalToSuperview().offset(popoverPosition.origin.y + popoverPosition.size.height / 2)
            }
            make.height.equalTo(80)
            make.width.equalTo(144)
        }
        
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

        animateView()
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
    
    // MARK: - Actions
    @objc private func clickReportButton(_ sender: UIButton) {
        
    }
    
    @objc private func clickBlockButton(_ sender: UIButton) {
        print("차단!")
    }
    
    @objc private func dismissPopover() {
        coordinator?.didFinish()
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

// MARK: - Animation
extension ReportPopoverViewController {
    func animateView() {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: .overrideInheritedCurve
        ) {
            // TODO: -
            self.view.layoutIfNeeded()
        } completion: { _ in
            print("animation")
        }
    }
}
