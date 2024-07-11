//
//  LinksDialogViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol LinksDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class LinksDialogViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: ProfileViewModel
    private weak var coordinator: LinksDialogViewControllerCoordinator?
    
    var dialogViewHeightAnchor: Constraint?
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 링크"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    private lazy var linkAddButton: CustomLinkAddButton = {
        let button = CustomLinkAddButton()
        button.addTarget(self, action: #selector(clickLinkAddButton(_:)), for: .touchUpInside)
        return button
    }()

    init(
        viewModel: ProfileViewModel,
        coordinator: LinksDialogViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(dialogView)
        
        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(linkAddButton)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            self.dialogViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalTo(xmarkButton.snp.leading).offset(-20)
            make.height.equalTo(24)
        }
        
        linkAddButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.height.equalTo(40)
            make.width.equalTo(
                (self.linkAddButton.customtextLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.linkAddButton.customtextLabel.font!]).width + 50
            )
        }
        
        self.view.layoutIfNeeded()
        
        dialogViewHeightAnchor?.update(offset: linkAddButton.frame.height + 66 + 20)
    }
    
    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc private func clickLinkAddButton(_ sender: UIButton) {
        viewModel.userLinks.append("blog.link")
        coordinator?.didFinish()
    }
//
//    @objc private func clickReasonButton(_ sender: CustomUsedToReportViewButton) {
//        switch sender.tag {
//        case 1:
//            didSelectCheckButton(reportReasonButton1)
//        case 2:
//            didSelectCheckButton(reportReasonButton2)
//        case 3:
//            didSelectCheckButton(reportReasonButton3)
//        case 4:
//            didSelectCheckButton(reportReasonButton4)
//        default:
//            break
//        }
//        updateReportButton()
//    }
//    
//    @objc private func clickBlockCheckButton(_ sender: CustomUsedToReportViewButton) {
//        didSelectCheckButton(sender)
//    }
//    
//    @objc private func clickReportButton(_ sender: UIButton) {
//        // TODO: - 신고
//        // 현재는 화면 이동만 진행
//        coordinator?.didReport()
//    }
}
