//
//  SearchSchoolCollectionViewCell.swift
//  ATeen
//
//  Created by 노주영 on 6/3/24.
//

import SnapKit

import UIKit

protocol SearchSchoolCollectionViewCellDelegate: AnyObject {
    func updateNextButtonState(_ state: Bool)
}

final class SearchSchoolCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private var viewModel = LoginBirthViewModel()
    private weak var delegate: SearchSchoolCollectionViewCellDelegate?
    
    var customIndicatorViewTopAnchor: Constraint?
    var customIndicatorViewBottomAnchor: Constraint?
    var customIndicatorViewHeightAnchor: Constraint?
    
    var tableBackgroundViewHeightAnchor: Constraint?
    
    var initialCenter = CGPoint()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "다니고 있는\n학교를 알려주세요"
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 10)
        return label
    }()
    
    lazy var schoolTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .gray
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.main.cgColor
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0) // 텍스트필드 앞에 공백 넣어주기
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged)
        return textField
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .main
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return imageView
    }()
    
    lazy var tableBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        view.backgroundColor = .gray03
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private lazy var customIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
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
        addDismissTapGesture()
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
            make.bottom.equalToSuperview().offset(-12)
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
    
    // MARK: - Actions
    func setProperties(delegate: SearchSchoolCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    private func addDismissTapGesture() { // VC영역 터치 시 안내려감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        tapGesture.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleBackgroundTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: contentView)
        if !tableBackgroundView.frame.contains(location) {
            tableBackgroundView.isHidden = true
        }
    }
    
    func setProperties(viewModel: LoginBirthViewModel) {
        self.viewModel = viewModel
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.filterSchools(text: text)
        viewModel.selectIndexPath = nil
        delegate?.updateNextButtonState(false)
        
        if viewModel.filteredSchools.isEmpty {
            tableBackgroundView.isHidden = true
        } else {
            tableBackgroundView.isHidden = false
            
            //            if let selectIndexPath = viewModel.selectIndexPath {
            //                let selectedCell = tableView.cellForRow(at: selectIndexPath) as? SearchSchoolResultTableViewCell
            //                selectedCell?.fontChange(with: viewModel.filteredSchools[selectIndexPath.row],
            //                                         isBold: false)
            //                viewModel.selectIndexPath = nil
            //            }
            
            if viewModel.filteredSchools.count < 6 {
                tableBackgroundViewHeightAnchor?.update(offset: viewModel.filteredSchools.count * 45)
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
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: customIndicatorView)
        
        if gestureRecognizer.state == .changed {
            initialCenter = customIndicatorView.center
            customIndicatorView.center = CGPoint(
                x: initialCenter.x,
                y: initialCenter.y + translation.y)
            
            // 테이블 뷰 스크롤
            let offsetY = translation.y
            tableView.contentOffset.y += offsetY
            gestureRecognizer.setTranslation(CGPoint.zero, in: customIndicatorView)
            
        } else if gestureRecognizer.state == .ended {
            let frame = customIndicatorView.frame
            let contentHeight = tableView.contentSize.height
            let visibleHeight = tableView.frame.height
            let indicatorHeight = (visibleHeight / contentHeight) * (visibleHeight - 34) - 22
            
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .showHideTransitionViews
            ) {
                if frame.origin.y < 23 {
                    self.tableView.scrollToRow(
                        at: IndexPath(row: 0, section: 0),
                        at: .top,
                        animated: true)
                    
                } else if frame.origin.y + indicatorHeight > self.tableBackgroundView.frame.height - 12 {
                    self.tableView.scrollToRow(
                        at: IndexPath(row: self.viewModel.filteredSchools.count - 1, section: 0),
                        at: .bottom,
                        animated: true)
                }
            }
            gestureRecognizer.setTranslation(.zero, in: customIndicatorView)
            initialCenter = CGPoint.zero
        }
    }
    
    func updateCustomIndicator() {
        self.layoutIfNeeded()
        
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.frame.height
        let indicatorHeight = (visibleHeight / contentHeight) * visibleHeight - 34
        let yOffset = (tableView.contentOffset.y / contentHeight * visibleHeight) + 22
        let bottomLine = self.tableBackgroundView.frame.height - 12
        
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
        viewModel.filteredSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchSchoolResultTableViewCell.reuseIdentifier,
                for: indexPath) as? SearchSchoolResultTableViewCell
        else {
            return UITableViewCell()
        }
        cell.fontChange(
            with: viewModel.filteredSchools[indexPath.row],
            isBold: indexPath == viewModel.selectIndexPath)
        
        cell.hiddenLineView(row: indexPath.row, lastIndex: viewModel.filteredSchools.count - 1)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchSchoolCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        47
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = viewModel.selectIndexPath {
            if let previousCell = tableView.cellForRow(at: previousIndexPath) as? SearchSchoolResultTableViewCell {
                previousCell.fontChange(
                    with: viewModel.filteredSchools[previousIndexPath.row],
                    isBold: false)
            }
        }
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SearchSchoolResultTableViewCell {
            selectedCell.fontChange(
                with: viewModel.filteredSchools[indexPath.row],
                isBold: true)
            
            viewModel.selectIndexPath = indexPath
            schoolTextField.text = viewModel.filteredSchools[indexPath.row]
            delegate?.updateNextButtonState(true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.filteredSchools.count >= 6 {
            updateCustomIndicator()
        }
    }
}

extension SearchSchoolCollectionViewCell: Reusable { }
