//
//  SearchUserViewController.swift
//  MainFeature
//
//  Created by 노주영 on 11/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import Combine
import DesignSystem
import UIKit

protocol SearchUserViewControllerCoordinator: AnyObject {
    func didFinish()
    func didSelectUser(frame: CGRect?, todayTeen: User, todayTeenFirstImage: UIImage)
    func configTabbarState(view: MainViewNames)
}

final class SearchUserViewController: UIViewController {
    private var debouncer: Debouncer?
    private var viewModel: SearchUserViewModel
    private weak var coordinator: SearchUserViewControllerCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var naviView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.leftArrowIcon.image, for: .normal)
        button.addTarget(self, action: #selector(didSelectBackButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = CustomClearXmarkTextField()
        textField.text = ""
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
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: SearchUserCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setupBindings()
        
        debouncer = Debouncer(interval: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .search)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
    init(
        viewModel: SearchUserViewModel,
        coordinator: SearchUserViewControllerCoordinator
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
        
        view.addSubview(naviView)
        view.addSubview(searchTableView)
        
        naviView.addSubview(backButton)
        naviView.addSubview(searchTextField)
    }
    
    private func configLayout() {
        naviView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(120)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalTo(backButton.snp.trailing).offset(13)
            make.height.equalTo(44)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(naviView.snp.bottom)
        }
    }

    private func setupBindings() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .success:
                    self.changeTextFieldRightView(view: .clearImage)
                    self.searchTableView.reloadData()
                    if !viewModel.searchUserList.isEmpty {
                        self.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                case .loading:
                    self.changeTextFieldRightView(view: .spinner)
                    break
                case .fail(error: let error):
                    self.changeTextFieldRightView(view: .searchImage)
                    print("검색한 학교가 없습니다. \(error)")
                }
            }.store(in: &cancellables)
    }
    
    private func changeTextFieldRightView(view: TextFieldRightViewType) {
        switch view {
        case .spinner:
            searchTextField.rightView = spinner
        case .searchImage:
            searchTextField.rightView = searchImageView
        case .clearImage:
            searchTextField.rightView = clearTextButton
        }
    }
    
    // MARK: - Actions
    @objc private func didSelectBackButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc private func textFieldDidChange(_ sender: Any?) {
        guard let text = searchTextField.text else { return }
        self.viewModel.searchUserText = text
        if !text.isEmpty {
            changeTextFieldRightView(view: .clearImage)
        } else {
            viewModel.clearListAndText()
            changeTextFieldRightView(view: .searchImage)
        }
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        searchTextField.text?.removeAll()
        viewModel.clearListAndText()
        changeTextFieldRightView(view: .searchImage)
    }
}

// MARK: - UITableViewDataSource
extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchUserCell.reuseIdentifier, for: indexPath) as? SearchUserCell else { return UITableViewCell() }
        let teen = viewModel.searchUserList[indexPath.row]
        cell.setProperties(user: .init(
            id: 0,
            uniqueId: teen.uniqueId,
            profileImage: teen.thumbnailUrl,
            nickName: teen.nickName,
            location: "",
            schoolName: "",
            birthDay: "",
            likeStatus: false))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teen = viewModel.searchUserList[indexPath.row]
        coordinator?.didSelectUser(
            frame: nil,
            todayTeen: .init(
                id: 0,
                uniqueId: teen.uniqueId,
                profileImage: teen.thumbnailUrl,
                nickName: teen.nickName,
                location: "",
                schoolName: "",
                birthDay: "",
                likeStatus: false),
            todayTeenFirstImage: DesignSystemAsset.badge1.image)
    }
}

// MARK: - UITextFieldDelegate
extension SearchUserViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        debouncer?.call { [weak self] in
            guard let self = self else { return }
            
            if viewModel.searchUserText.count > 0 {
                viewModel.getSearchUserList()
                searchTableView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
