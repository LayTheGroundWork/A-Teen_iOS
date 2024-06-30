//
//  RankingResultViewController.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public protocol RankingResultViewControllerCoordinator: AnyObject {
    func didTapBackButton()
}

public final class RankingResultViewController: UIViewController {
    private weak var coordinator: RankingResultViewControllerCoordinator?
    let sector: String
    
    // Sample data with 16 items, proportions summing to 90
    private let rankings = [
        (rank: 1, userName: "User1", proportion: 11.2),
        (rank: 2, userName: "User2", proportion: 10.5),
        (rank: 3, userName: "User3", proportion: 10.1),
        (rank: 4, userName: "User4", proportion: 7.5),
        (rank: 5, userName: "User5", proportion: 7.0),
        (rank: 6, userName: "User6", proportion: 6.5),
        (rank: 7, userName: "User7", proportion: 6.0),
        (rank: 8, userName: "User8", proportion: 5.5),
        (rank: 9, userName: "User9", proportion: 5.0),
        (rank: 10, userName: "User10", proportion: 4.5),
        (rank: 11, userName: "User11", proportion: 4.0),
        (rank: 12, userName: "User12", proportion: 3.5),
        (rank: 13, userName: "User13", proportion: 3.0),
        (rank: 14, userName: "User14", proportion: 2.5),
        (rank: 15, userName: "User15", proportion: 2.0),
        (rank: 16, userName: "User16", proportion: 1.5)
    ]
    
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
        let button = UIButton()
        button.setImage(DesignSystemAsset.leftArrowWhiteIcon.image,
                        for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self,
                         action: #selector(didSelectBackButton(_:)),
                         for: .touchUpInside)

        let label = UILabel()
        label.text = "이번 주 대결"
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textAlignment = .center
        
        let customView = UIStackView(arrangedSubviews: [button, label])
        customView.axis = .horizontal
        customView.alignment = .center
        customView.spacing = 10
        
        let buttonItem = UIBarButtonItem(customView: customView)
        return buttonItem
        
    }()
    
    private lazy var rankingSubText: UILabel = {
        let label = UILabel()
        label.text = "\(sector) 부문 TEEN 순위"
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var firstBox: UIView = CustomRankingTopView(
        image: DesignSystemAsset.dressGlass.image,
        rank: .first,
        userName: "XXX",
        proportion: 20.0)
    
    private lazy var secondBox: UIView = CustomRankingTopView(
        image: DesignSystemAsset.blackGlass.image,
        rank: .second,
        userName: "흐르미",
        proportion: 18.7)
    
    private lazy var thirdBox: UIView = CustomRankingTopView(
        image: DesignSystemAsset.whiteGlass.image,
        rank: .third,
        userName: "XXX",
        proportion: 12.3)
    
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
        configUserInterface()
        configLayout()
    }
    
    init(
        coordinator: RankingResultViewControllerCoordinator,
        sector: String
    ) {
        self.coordinator = coordinator
        self.sector = sector
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = DesignSystemAsset.backgroundColor.color
        
        navigationItem.leftBarButtonItem = backButton

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
    
    // MARK: - Actions
    @objc private func didSelectBackButton(_ sender: UIButton) {
        coordinator?.didTapBackButton()
    }
}

// MARK: - Extensions here
extension RankingResultViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        let cellHeight: CGFloat = 95
        let topPadding: CGFloat = 10
        return cellHeight + topPadding
    }
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // TODO: - 해당 프로필 이동
        print("\(rankings[indexPath.row + 3].rank) 위 cell 클릭")
    }
}

extension RankingResultViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        // (총 인원 - 3) 현재 16 명 중 top 3 제외
        rankings.count - 3
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RankingResultTableViewCell.reuseIdentifier,
            for: indexPath) as? RankingResultTableViewCell
        else {
            return UITableViewCell()
        }
        // top 3 이후로 table view 에 보여주기 때문에, indexPath.row + 3
        let ranking = rankings[indexPath.row + 3]
        cell.setProperties(rank: ranking.rank,
                           userName: ranking.userName,
                           proportion: ranking.proportion)
        return cell
    }
}
