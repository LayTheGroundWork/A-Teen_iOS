//
//  QuestionsViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol QuestionsViewControllerCoordinator: AnyObject {
    func didTabBackButton()
    func didTabCell(index: Int)
    func didTabSelectQuestionButton()
    func configTabbarState(view: ProfileFeatureViewNames)
}


public protocol QuestionsViewControllerDelegate: AnyObject {
    func didTabBackButtonFromQuestionsDialogViewController()
}

public final class QuestionsViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: QuestionsViewModel
    private weak var coordinator: QuestionsViewControllerCoordinator?
    
    var backgroundViewHeightAnchor: Constraint?
    var tableViewHeightAnchor: Constraint?
    
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
        label.text = "자문자답 정보 수정"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var questionsLabel: UILabel = {
        let label = UILabel()
        label.text = "나를 소개할 수 있는\n질문을 선택해서 답해주세요 :)"
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var explainCountLabel: UILabel = {
        let label = UILabel()
        label.text = "*최소 3개"
        label.textColor = DesignSystemAsset.gray01.color
        label.textAlignment = .right
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.systemBackground
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 84, right: 0)
        return scrollView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.clipsToBounds = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = DesignSystemAsset.gray03.color
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuestionsTableViewCell.self, forCellReuseIdentifier: QuestionsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var selectQuestionButton: CustomSelectQuestionButton = {
        let button = CustomSelectQuestionButton()
        button.addTarget(self, action: #selector(clickSelectQuestionButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.completeEdit, for: .normal)
        button.setTitle(AppLocalized.completeEdit, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .disabled)
        button.backgroundColor = DesignSystemAsset.gray03.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.addTarget(self, action: #selector(clickSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .another)
        changeCheckQuestion()
    }
    
    public init(
        viewModel: QuestionsViewModel,
        coordinator: QuestionsViewControllerCoordinator
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
        view.addSubview(explainCountLabel)
        view.addSubview(questionsLabel)
        view.addSubview(saveButton)
        view.addSubview(scrollView)
        
        scrollView.addSubview(backgroundView)
        
        backgroundView.addSubview(tableView)
        backgroundView.addSubview(selectQuestionButton)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
        }
        
        explainCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(39)
            make.width.equalTo(60)
            make.height.equalTo(17)
        }
        
        questionsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(explainCountLabel.snp.leading).offset(-10)
            make.bottom.equalTo(explainCountLabel.snp.bottom)
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-48)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(questionsLabel.snp.bottom).offset(42)
            make.bottom.equalTo(saveButton.snp.top).offset(-ViewValues.defaultPadding)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(self.scrollView.frameLayoutGuide)
            self.backgroundViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview()
            self.tableViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        selectQuestionButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(tableView.snp.bottom).offset(19)
            make.height.equalTo(44)
        }
        
        changeHeight()
    }
    
    private func calculateLabelHeight(for label: UILabel, width: CGFloat) -> CGFloat {
        guard let text = label.text, let font = label.font else {
            return 0
        }
        
        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingBox = text.boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return boundingBox.height
    }
    
    private func changeHeight() {
        changeTotalViewHeight(height: tableView.frame.height + 20)
        
        self.view.layoutIfNeeded()
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? QuestionsTableViewCell else {
            changeTotalViewHeight(height: 0)
            return
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.customFont(forTextStyle: .subheadline, weight: .bold)
        titleLabel.numberOfLines = 0
        
        let textLabelHeight = cell.questionTextLabel.frame.height
        
        var totalHeight: CGFloat = 0.0
        
        viewModel.changeQuestionList.forEach { question in
            titleLabel.text = question.title
            
            let height = calculateLabelHeight(for: titleLabel, width: ViewValues.width - 96) + textLabelHeight + 43
            totalHeight += height
        }
        
        changeTotalViewHeight(height: totalHeight)
    }
    
    private func changeTotalViewHeight(height: CGFloat) {
        self.view.layoutIfNeeded()
        
        tableViewHeightAnchor?.update(offset: height)
        
        self.view.layoutIfNeeded()
        
        backgroundViewHeightAnchor?.update(offset: tableView.frame.height + selectQuestionButton.frame.height + 19)
        
        self.view.layoutIfNeeded()
        
        self.scrollView.contentSize = CGSize(
            width: self.view.frame.width,
            height: backgroundView.frame.height)
    }
    
    private func animationOfTableview() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
            self.changeHeight()
        }
    }
    
    private func changeCheckQuestion() {
        if viewModel.checkChangeQuestion() {
            saveButton.isEnabled = false
            saveButton.backgroundColor = DesignSystemAsset.gray03.color
        } else {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor.black
        }
    }
    
    // MARK: - Actions
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didTabBackButton()
    }
    
    @objc private func clickSelectQuestionButton(_ sender: UIButton) {
        coordinator?.didTabSelectQuestionButton()
    }
    
    @objc private func clickSaveButton(_ sender: UIButton) {
        viewModel.saveChangeValue { success, error in
            if success {
                self.coordinator?.didTabBackButton()     //일단 끝나면 뒤로 처리
            } else {
                switch error {
                case .notChange:
                    print("변경사항 없음")
                case .textNil:
                    print("텍스트 없음")
                case .none:
                    break
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension QuestionsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: QuestionsTableViewCell.reuseIdentifier,
                for: indexPath) as? QuestionsTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setProperties(question: viewModel.changeQuestionList[indexPath.row])
        cell.deleteButtonAction = { [weak self] in
            guard let self = self else { return }
            
            if let indexPath = tableView.indexPath(for: cell) {
                self.viewModel.changeQuestionList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                animationOfTableview()
                changeCheckQuestion()
            }
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.changeQuestionList.count
    }
}

extension QuestionsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.didTabCell(index: indexPath.row)
    }
}

extension QuestionsViewController: QuestionsViewControllerDelegate {
    public func didTabBackButtonFromQuestionsDialogViewController() {
        self.tableView.reloadData()
        animationOfTableview()
    }
}
