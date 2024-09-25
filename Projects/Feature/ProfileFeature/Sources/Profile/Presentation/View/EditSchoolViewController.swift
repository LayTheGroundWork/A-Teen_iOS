//
//  EditSchoolViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import Domain
import UIKit

public protocol EditSchoolViewControllerCoordinator: AnyObject {
    func didTabBackButton()
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class EditSchoolViewController: UIViewController {
    // MARK: - Private properties
    private var searchTask: DispatchWorkItem?
    private var debouncer: Debouncer?
    private var viewModel: EditSchoolViewModel
    private weak var coordinator: EditSchoolViewControllerCoordinator?
    
    var customIndicatorViewTopAnchor: Constraint?
    var customIndicatorViewBottomAnchor: Constraint?
    var customIndicatorViewHeightAnchor: Constraint?
    
    var tableBackgroundViewHeightAnchor: Constraint?
    
    var initialCenter = CGPoint()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowIcon.image,
            style: .done,
            target: self,
            action: #selector(clickBackButton(_:)))
        button.tintColor = UIColor.black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "학교 수정"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 다니는 학교를 검색해서 수정해보세요!"
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    lazy var schoolTextField: UITextField = {
        let textField = CustomClearXmarkTextField()
        textField.text = viewModel.searchSchoolText
        textField.tintColor = DesignSystemAsset.gray01.color
        textField.font = .customFont(forTextStyle: .callout, weight: .bold)
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.clearButtonMode = .never
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = searchImageView
        textField.rightViewMode = .always
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        return spinner
    }()
    
    private lazy var paddingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        return view
    }()
    
    private lazy var clearTextButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.clearButton.image, for: .normal)
        button.addTarget(self, action: #selector(didSelectClearTextButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = DesignSystemAsset.mainColor.color
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return imageView
    }()
    
    lazy var tableBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.isHidden = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchSchoolResultTableViewCell.self,
                           forCellReuseIdentifier: SearchSchoolResultTableViewCell.reuseIdentifier)
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
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .customFont(forTextStyle: .callout, weight: .regular)
        button.setTitle(AppLocalized.completeEdit, for: .normal)
        button.setTitle(AppLocalized.completeEdit, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .disabled)
        button.backgroundColor = DesignSystemAsset.gray03.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        button.addTarget(self, action: #selector(clickSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        
        debouncer = Debouncer(interval: 0.5)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .another)
        
        if viewModel.searchSchoolText.isEmpty {
            changeTextFieldRigthView(view: .searchImage)
        } else {
            changeTextFieldRigthView(view: .clearImage)
        }
    }
    
    public init(
        viewModel: EditSchoolViewModel,
        coordinator: EditSchoolViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(schoolTextField)
        view.addSubview(tableBackgroundView)
        view.addSubview(saveButton)
        
        tableBackgroundView.addSubview(customIndicatorBackgroudView)
        tableBackgroundView.addSubview(customIndicatorView)
        tableBackgroundView.addSubview(tableView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        schoolTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(44)
        }
        
        tableBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(schoolTextField.snp.bottom).offset(10)
            self.tableBackgroundViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        customIndicatorBackgroudView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().offset(-22)
            make.width.equalTo(5)
        }
        
        customIndicatorView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            self.customIndicatorViewTopAnchor = make.top.equalToSuperview().offset(22).constraint
            make.width.equalTo(5)
            self.customIndicatorViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(self.customIndicatorView.snp.leading).offset(-22)
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-48)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
    }
    
    public func changeTextFieldRigthView(view: TextFieldRightViewType) {
        switch view {
        case .spinner:
            schoolTextField.rightView = spinner
        case .searchImage:
            schoolTextField.rightView = searchImageView
        case .clearImage:
            schoolTextField.rightView = clearTextButton
        }
    }
    
    private func changeCheckSchoolData() {
        if viewModel.checkChangeSchoolData() {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor.black
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = DesignSystemAsset.gray03.color
        }
    }
    
    private func openSearchSchoolTableView() {
        tableBackgroundView.isHidden = false
        
        if viewModel.filteredSchools.count < 6 {
            tableBackgroundViewHeightAnchor?.update(offset: self.viewModel.filteredSchools.count * 59)
            tableView.reloadData()
            tableView.isScrollEnabled = false
            
            customIndicatorBackgroudView.isHidden = true
            customIndicatorViewTopAnchor?.update(offset: 22)
            customIndicatorViewHeightAnchor?.update(offset: 0)
        } else {
            customIndicatorBackgroudView.isHidden = false
            tableBackgroundViewHeightAnchor?.update(offset: 240)
            
            tableView.reloadData()
            tableView.isScrollEnabled = true
            
            updateCustomIndicator()
        }
    }
    
    private func closeSearchScoolTableView() {
        tableBackgroundViewHeightAnchor?.update(offset: 0)
    }
    
    private func reloadTableViewData() {
        if viewModel.filteredSchools.isEmpty {
            closeSearchScoolTableView()
        } else {
            openSearchSchoolTableView()
        }
    }
    
    private func updateCustomIndicator() {
        self.view.layoutIfNeeded()
        
        let contentHeight = tableView.contentSize.height
        let visibleHeight = customIndicatorBackgroudView.frame.height
        let bottomLine = self.tableBackgroundView.frame.height - 22
        let yOffset = tableView.contentOffset.y / contentHeight * visibleHeight + 22
        let indicatorHeight = tableView.frame.height / contentHeight * visibleHeight
        
        if contentHeight == 0 {
            self.customIndicatorViewTopAnchor?.update(offset: 22)
            self.customIndicatorViewHeightAnchor?.update(offset: 0)
        } else {
            if yOffset < 22 {
                self.customIndicatorViewTopAnchor?.update(offset: 22)
                
                if (indicatorHeight + yOffset - 22) <= 0 {
                    self.customIndicatorViewHeightAnchor?.update(offset: 0)
                } else {
                    self.customIndicatorViewHeightAnchor?.update(offset: indicatorHeight + yOffset - 22)
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
}

// MARK: - Actions
extension EditSchoolViewController {
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didTabBackButton()
    }
    
    @objc private func clickSaveButton(_ sender: UIButton) {
        // TODO: 서버 저장 로직 필요
        coordinator?.didTabBackButton()
    }
    
    @objc private func textFieldDidChange(_ sender: Any?) {
        guard let text = schoolTextField.text else { return }
        self.viewModel.searchSchoolText = text
        if text.isEmpty {
            changeTextFieldRigthView(view: .searchImage)
        } else {
            changeTextFieldRigthView(view: .clearImage)
        }
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        schoolTextField.text?.removeAll()
        viewModel.searchSchoolText = .empty
        viewModel.changeSchool = .init(schoolName: .empty, schoolLocation: .empty)
        changeTextFieldRigthView(view: .searchImage)
        closeSearchScoolTableView()
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
            let visibleHeight = customIndicatorBackgroudView.frame.height
            let indicatorHeight = tableView.frame.height / contentHeight * visibleHeight
            
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .showHideTransitionViews
            ) { [weak self] in
                guard let self = self else { return }
                if frame.origin.y < 23 {
                    self.tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0),
                        at: .top,
                        animated: true)
                    
                } else if frame.origin.y + indicatorHeight > self.tableBackgroundView.frame.height - 22 {
                    self.tableView.scrollToRow(
                        at: IndexPath(
                            row: self.viewModel.filteredSchools.count - 1,
                            section: 0),
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
}

// MARK: - UITableViewDataSource
extension EditSchoolViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredSchools.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchSchoolResultTableViewCell.reuseIdentifier,
                for: indexPath) as? SearchSchoolResultTableViewCell,
            indexPath.row <= viewModel.filteredSchools.count
        else {
            return UITableViewCell()
        }
        
        let schoolData = viewModel.filteredSchools[indexPath.row]
        cell.fontChange(
            schoolData: schoolData,
            isBold: viewModel.changeSchool == schoolData)
        
        cell.hiddenLineView(row: indexPath.row, lastIndex: viewModel.filteredSchools.count - 1)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EditSchoolViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        59
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SearchSchoolResultTableViewCell {
            selectedCell.fontChange(
                schoolData: viewModel.filteredSchools[indexPath.row],
                isBold: true)
            
            let schoolData = viewModel.filteredSchools[indexPath.row]
            viewModel.changeSchool = schoolData
            viewModel.searchSchoolText = schoolData.schoolName
            schoolTextField.text = schoolData.schoolName
            schoolTextField.font = .customFont(forTextStyle: .callout, weight: .bold)
            
            view.endEditing(true)
            changeCheckSchoolData()
            closeSearchScoolTableView()
            
            self.view.layoutIfNeeded()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.filteredSchools.count >= 6 {
            updateCustomIndicator()
        }
    }
}

// MARK: - UITextFieldDelegate
extension EditSchoolViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        openSearchSchoolTableView()
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if viewModel.changeSchool.schoolName != schoolTextField.text {
            schoolTextField.font = .customFont(forTextStyle: .callout, weight: .regular)
        }
        
        if viewModel.changeSchool.schoolName != schoolTextField.text {
            
            debouncer?.call { [weak self] in
                guard let self = self else { return }
                
                if viewModel.searchSchoolText.count > 0 {
                    viewModel.searchSchoolData {
                        DispatchQueue.main.async {
                            self.reloadTableViewData()
                            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                        }
                    }
                } else {
                    closeSearchScoolTableView()
                }
            }
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
