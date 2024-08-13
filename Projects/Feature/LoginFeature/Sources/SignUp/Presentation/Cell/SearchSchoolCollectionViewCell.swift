//
//  SearchSchoolCollectionViewCell.swift
//  ATeen
//
//  Created by 노주영 on 6/3/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

protocol SearchSchoolCollectionViewCellDelegate: AnyObject {
    func updateNextButtonState(_ state: Bool)
}

final class SearchSchoolCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private var searchTask: DispatchWorkItem?
    private var debouncer: Debouncer?
    private weak var delegate: SearchSchoolCollectionViewCellDelegate?
    private var viewModel: SignUpViewModel?
    
    var customIndicatorViewTopAnchor: Constraint?
    var customIndicatorViewBottomAnchor: Constraint?
    var customIndicatorViewHeightAnchor: Constraint?
    
    var tableBackgroundViewHeightAnchor: Constraint?
    
    var initialCenter = CGPoint()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.text = AppLocalized.searchSchoolTitle
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 10)
        return label
    }()
    
    lazy var schoolTextField: UITextField = {
        let textField = CustomClearXmarkTextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.tintColor = DesignSystemAsset.gray01.color
        textField.font = .customFont(forTextStyle: .callout, weight: .regular)
        textField.clearButtonMode = .never
        textField.rightView = searchImageView
        textField.rightViewMode = .always
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        return spinner
    }()
    
    private lazy var clearTextButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.clearButton.image, for: .normal)
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
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
        setupActions()
        
        debouncer = Debouncer(interval: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(schoolTextField)
        contentView.addSubview(tableBackgroundView)
        
        tableBackgroundView.addSubview(customIndicatorBackgroudView)
        tableBackgroundView.addSubview(customIndicatorView)
        tableBackgroundView.addSubview(tableView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalToSuperview()
        }
        
        schoolTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        
        tableBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(schoolTextField.snp.bottom).offset(10)
            self.tableBackgroundViewHeightAnchor = make.height.equalTo(240).constraint
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
    }
    
    private func setupActions() {
        schoolTextField.addTarget(self,
                                  action: #selector(textFieldDidChange),
                                  for: .editingChanged)
        
        clearTextButton.addTarget(self,
                                  action: #selector(didSelectClearTextButton(_:)),
                                  for: .touchUpInside)
    }
    
    func setProperties(
        delegate: SearchSchoolCollectionViewCellDelegate,
        viewModel: SignUpViewModel
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    // MARK: - Actions
    @objc private func textFieldDidChange(_ sender: Any?) {
        guard let text = schoolTextField.text else { return }
        self.viewModel?.searchSchoolText = text
        if !text.isEmpty {
            changeTextFieldRigthView(view: .clearImage)
        }
        
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        schoolTextField.text?.removeAll()
        self.viewModel?.searchSchoolText = .empty
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
                            row: (self.viewModel?.filteredSchools.count ?? 0) - 1,
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
    
    public func reloadTableViewData() {
        tableView.reloadData()
        
        if viewModel?.filteredSchools.isEmpty == true {
            closeSearchScoolTableView()
        } else {
            openSearchScoolTableView()
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
    
    private func openSearchScoolTableView() {
        tableBackgroundView.isHidden = false
        
        if viewModel?.filteredSchools.count ?? 0 < 6 {
            tableBackgroundViewHeightAnchor?.update(offset: (viewModel?.filteredSchools.count ?? 0) * 59)
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
        tableBackgroundView.isHidden = true
        viewModel?.selectIndexPath = nil
        viewModel?.schoolData = .init(schoolName: .empty,
                                      schoolLocation: .empty)
        viewModel?.filteredSchools = []
    }
    
    private func updateCustomIndicator() {
        self.layoutIfNeeded()
        
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

// MARK: - UITableViewDataSource
extension SearchSchoolCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.filteredSchools.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchSchoolResultTableViewCell.reuseIdentifier,
                for: indexPath) as? SearchSchoolResultTableViewCell,
            indexPath.row <= viewModel?.filteredSchools.count ?? 0
        else {
            return UITableViewCell()
        }

        cell.fontChange(
            schoolData: viewModel?.filteredSchools[indexPath.row],
            isBold: indexPath == viewModel?.selectIndexPath)
        
        cell.hiddenLineView(row: indexPath.row, lastIndex: (viewModel?.filteredSchools.count ?? 0) - 1)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchSchoolCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        59
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = viewModel?.selectIndexPath {
            if let previousCell = tableView.cellForRow(at: previousIndexPath) as? SearchSchoolResultTableViewCell {
                previousCell.fontChange(
                    schoolData: viewModel?.filteredSchools[previousIndexPath.row],
                    isBold: false)
            }
        }
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SearchSchoolResultTableViewCell {
            selectedCell.fontChange(
                schoolData: viewModel?.filteredSchools[indexPath.row],
                isBold: true)
            
            viewModel?.searchSchoolText = .empty
            viewModel?.selectIndexPath = indexPath
            viewModel?.schoolData = viewModel?.filteredSchools[indexPath.row] ?? .init(schoolName: .empty, schoolLocation: .empty)
            schoolTextField.text = viewModel?.filteredSchools[indexPath.row].schoolName
            // '다음으로' 버튼 활성화
            delegate?.updateNextButtonState(true)
            // 키보드 닫기
            contentView.endEditing(true)
            // 검색어 테이블뷰 닫기
            closeSearchScoolTableView()
            // 학교 선택 시, bold 처리
            schoolTextField.font = .customFont(forTextStyle: .callout, weight: .bold)
            layoutIfNeeded()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel?.filteredSchools.count ?? 0 >= 6 {
            updateCustomIndicator()
        }
    }
}

// MARK: - UITextFieldDelegate
extension SearchSchoolCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openSearchScoolTableView()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        schoolTextField.font = .customFont(forTextStyle: .callout, weight: .regular)
        
        debouncer?.call { [weak self] in
            guard let self = self else { return }
            if viewModel?.searchSchoolText.count != .zero {
                viewModel?.searchSchoolData {
                    DispatchQueue.main.async {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
            } else {
                closeSearchScoolTableView()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return true
    }
}

extension SearchSchoolCollectionViewCell: Reusable { }
