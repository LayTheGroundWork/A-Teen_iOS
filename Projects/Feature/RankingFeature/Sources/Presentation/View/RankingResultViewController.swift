//
//  RankingResultViewController.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Combine
import DesignSystem
import UIKit

public protocol RankingResultViewControllerCoordinator: AnyObject {
    func didTapBackButton()
    func configTabbarState(view: RankingFeatureViewNames)
}

public final class RankingResultViewController: UIViewController {
    private var viewModel: RankingResultViewModel
    private weak var coordinator: RankingResultViewControllerCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Private properties
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowWhiteIcon.image,
            style: .plain,
            target: self,
            action: #selector(didSelectBackButton(_:)))
        button.tintColor = .white
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.round == 0 ? "이번 주 대결" : "\(viewModel.round)회차 대결"
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rankingSubText: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.category) 부문 TEEN 순위"
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var firstBox: UIView = CustomRankingTopView(
        image: DesignSystemAsset.badge8.image,
        rank: .first,
        userName: viewModel.tournamentResultList[0].rankerNickName,
        proportion: viewModel.getPercentage(voteCount: viewModel.tournamentResultList[0].score))
    
    private lazy var secondBox: UIView = CustomRankingTopView(
        image: DesignSystemAsset.badge6.image,
        rank: .second,
        userName: viewModel.tournamentResultList[1].rankerNickName,
        proportion: viewModel.getPercentage(voteCount: viewModel.tournamentResultList[1].score))
    
    private lazy var thirdBox: UIView = CustomRankingTopView(
        image: DesignSystemAsset.badge2.image,
        rank: .third,
        userName: viewModel.tournamentResultList[2].rankerNickName,
        proportion: viewModel.getPercentage(voteCount: viewModel.tournamentResultList[2].score))
    
    private lazy var topThreeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            secondBox, firstBox, thirdBox])
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .bottom
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RankingResultTableViewCell.self,
                           forCellReuseIdentifier: RankingResultTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        viewModel.getTournamentResult()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .rankingResult)
        navigationController?.isNavigationBarHidden = false
    }
    
    init(
        viewModel: RankingResultViewModel,
        coordinator: RankingResultViewControllerCoordinator
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
        view.backgroundColor = DesignSystemAsset.backgroundColor.color
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel
        
        view.addSubview(backgroundView)
        view.addSubview(rankingSubText)
        view.addSubview(topThreeStack)
        view.addSubview(tableView)
    }
    
    private func configLayout() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(ViewValues.height * 0.28)
        }
        
        rankingSubText.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        topThreeStack.snp.makeConstraints { make in
            make.top.equalTo(rankingSubText.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topThreeStack.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.configUserInterface()
                self.configLayout()
            }.store(in: &cancellables)
    }
    
    // MARK: - Actions
    @objc private func didSelectBackButton(_ sender: UIButton) {
        coordinator?.didTapBackButton()
    }
}

// MARK: - Extensions here
extension RankingResultViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight: CGFloat = 95
        let topPadding: CGFloat = 10
        return cellHeight + topPadding
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - 해당 프로필 이동
        print("\(viewModel.tournamentResultList[indexPath.row].rank) 위 cell 클릭")
    }
}

extension RankingResultViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tournamentResultList.count - 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RankingResultTableViewCell.reuseIdentifier,
            for: indexPath) as? RankingResultTableViewCell
        else {
            return UITableViewCell()
        }
        // top 3 이후로 table view 에 보여주기 때문에, indexPath.row + 3
        let ranker = viewModel.tournamentResultList[indexPath.row + 3]
        cell.setProperties(rank: ranker.rank,
                           userName: ranker.rankerNickName,
                           userID: ranker.rankerId,
                           proportion: viewModel.getPercentage(voteCount: ranker.score))
        return cell
    }
}
