//
//  QuestionsDialogViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import FeatureDependency
import UIKit

public protocol QuestionsDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

open class QuestionsDialogViewController: UIViewController {
    private var viewModel: QuestionsViewModel
    private weak var coordinator: QuestionsDialogViewControllerCoordinator?
    
    var customIndicatorViewTopAnchor: Constraint?
    var customIndicatorViewBottomAnchor: Constraint?
    var customIndicatorViewHeightAnchor: Constraint?
    
    var initialCenter = CGPoint()
    
    // MARK: - Private properties
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        label.text = "마음에 드는 질문을 선택해주세요"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    lazy var tableBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuestionsDialogTableViewCell.self,
                           forCellReuseIdentifier: QuestionsDialogTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var customIndicatorBackgroudView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private lazy var customIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        view.layer.cornerRadius = 2.5
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        return view
    }()
    
    // MARK: - Life Cycle
    public init(
        viewModel: QuestionsViewModel,
        coordinator: QuestionsDialogViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        view.addSubview(dialogView)
        
        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(tableBackgroundView)
        
        tableBackgroundView.addSubview(customIndicatorBackgroudView)
        tableBackgroundView.addSubview(customIndicatorView)
        tableBackgroundView.addSubview(tableView)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            make.height.equalTo(ViewValues.halfHeight)
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(47)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        tableBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
        }
        
        customIndicatorBackgroudView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(27)
            make.bottom.equalToSuperview().offset(-27)
            make.width.equalTo(5)
        }
        
        customIndicatorView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.equalTo(5)
            self.customIndicatorViewTopAnchor = make.top.equalToSuperview().offset(27).constraint
            self.customIndicatorViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.bottom.equalToSuperview().offset(-27)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(self.customIndicatorView.snp.leading).offset(-22)
        }
        
        updateCustomIndicator()
    }
}

// MARK: - Action
extension QuestionsDialogViewController {
    private func updateCustomIndicator() {
        self.view.layoutIfNeeded()
        
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.frame.height
        let indicatorHeight = (visibleHeight / contentHeight) * visibleHeight
        let yOffset = (tableView.contentOffset.y / contentHeight * visibleHeight) + 27
        let bottomLine = self.tableBackgroundView.frame.height - 27
        
        if contentHeight == 0 {
            self.customIndicatorViewTopAnchor?.update(offset: 27)
            self.customIndicatorViewHeightAnchor?.update(offset: 0)
        } else {
            if yOffset < 27 {
                self.customIndicatorViewTopAnchor?.update(offset: 27)
                
                if (indicatorHeight + yOffset - 27) <= 0 {
                    self.customIndicatorViewHeightAnchor?.update(offset: 0)
                } else {
                    self.customIndicatorViewHeightAnchor?.update(offset: indicatorHeight + yOffset - 27)
                }
            } else if yOffset + indicatorHeight > bottomLine {
                self.customIndicatorViewTopAnchor?.update(offset: yOffset)
                
                if bottomLine <= yOffset {
                    self.customIndicatorViewHeightAnchor?.update(offset: 0)
                } else {
                    self.customIndicatorViewHeightAnchor?.update(offset: bottomLine - yOffset)
                }
            } else {
                self.customIndicatorViewTopAnchor?.update(offset: yOffset)
                self.customIndicatorViewHeightAnchor?.update(offset: indicatorHeight)
            }
        }
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: customIndicatorView)
        
        switch gestureRecognizer.state {
        case .changed:
            initialCenter = customIndicatorView.center
            customIndicatorView.center = CGPoint(
                x: initialCenter.x,
                y: initialCenter.y + translation.y)
            
            // 테이블 뷰 스크롤
            let offsetY = translation.y
            tableView.contentOffset.y += offsetY
            gestureRecognizer.setTranslation(CGPoint.zero, in: customIndicatorView)
            
        case .ended, .cancelled:
            let frame = customIndicatorView.frame
            let contentHeight = tableView.contentSize.height
            let visibleHeight = tableView.frame.height
            let indicatorHeight = (visibleHeight / contentHeight) * (visibleHeight - 54) - 27
            
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .showHideTransitionViews
            ) {
                print(frame.origin.y)
                if frame.origin.y <= 27 {
                    self.tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0),
                        at: .top,
                        animated: true)
                    
                } else if frame.origin.y + indicatorHeight > self.tableBackgroundView.frame.height - 27 {
                    self.tableView.scrollToRow(
                        at: IndexPath(row: self.viewModel.sampleQuestionList.count - 1, section: 0),
                        at: .bottom,
                        animated: true)
                }
            }
            gestureRecognizer.setTranslation(.zero, in: customIndicatorView)
            initialCenter = CGPoint.zero
            
        default:
            break
        }
    }
    
    @objc func clickCloseButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
}

// MARK: - UITableViewDataSource
extension QuestionsDialogViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sampleQuestionList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: QuestionsDialogTableViewCell.reuseIdentifier,
                for: indexPath) as? QuestionsDialogTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setProperties(viewModel: viewModel, index: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuestionsDialogViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = viewModel.changeQuestionList.firstIndex(where: { $0.title == viewModel.sampleQuestionList[indexPath.row] }) {
            viewModel.changeQuestionList.remove(at: index)
            
            guard let cell = tableView.cellForRow(at: indexPath) as? QuestionsDialogTableViewCell else { return }
            
            cell.questionLabel.font = .customFont(forTextStyle: .footnote, weight: .regular)
        } else {
            viewModel.changeQuestionList.append(
                .init(
                    title: viewModel.sampleQuestionList[indexPath.row],
                    text: AppLocalized.textViewPlaceHolder)
            )
            coordinator?.didFinish()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCustomIndicator()
    }
}

