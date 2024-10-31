//
//  TournamentViewController.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public protocol TournamentViewControllerCoordinator: AnyObject {
    func quitTournament()
    func finishTournament(
        category: String,
        round: Int,
        tournamentNo: Int)
    func openQuitDialog()
    func configTabbarState(view: RankingFeatureViewNames)
}

public final class TournamentViewController: UIViewController {
    private var viewModel: TournamentViewModel
    private weak var coordinator: TournamentViewControllerCoordinator?
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowWhiteIcon.image,
            style: .plain,
            target: self,
            action: #selector(didSelectCloseButton(_:)))
        button.tintColor = .white
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.category
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(
            width: ViewValues.width,
            height: ViewValues.height - 80)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(TournamentRoundCollectionViewCell.self, forCellWithReuseIdentifier: TournamentRoundCollectionViewCell.reuseIdentifier)
        collectionView.register(TournamentEndCollectionViewCell.self, forCellWithReuseIdentifier: TournamentEndCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .tournament)
        navigationController?.isNavigationBarHidden = false
    }
    
    init(
        viewModel: TournamentViewModel,
        coordinator: TournamentViewControllerCoordinator
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
        view.backgroundColor = UIColor.black
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.titleView = titleLabel
        
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func scrollToPage(section: Int) {
        let indexPath = IndexPath(item: 0, section: section)
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: false)
    }
    
    // MARK: - Actions
    @objc private func didSelectCloseButton(_ sender: UIButton) {
        switch viewModel.currentRound {
        case .roundOf16, .roundOf8, .semifinals, .final:
            coordinator?.openQuitDialog()
        case .end:
            coordinator?.quitTournament()
        }
    }
}

// MARK: - Extensions here
extension TournamentViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 16강, 8강, 4강, 결승 + 완료 페이지
        TournamentRoundType.allCases.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 4:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TournamentEndCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TournamentEndCollectionViewCell,
                  let winner = viewModel.winner
            else {
                return UICollectionViewCell()
            }
            
            viewModel.editVoteResult()
            
            cell.setProperties(
                delegate: self,
                winner: winner,
                age: viewModel.getUserAge(userBirth: winner.userBirth))
 
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TournamentRoundCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TournamentRoundCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setProperties(delegate: self, viewModel: viewModel)
            
            return cell
        }
    }
}

extension TournamentViewController: TournamentRoundCollectionViewCellDelegate {
    public func nextRound() {
        guard let section = viewModel.changeRound() else { return }
        scrollToPage(section: section)
    }
}

extension TournamentViewController: TournamentEndCollectionViewCellDelegate {
    func finishTournament() {
        guard let winner = viewModel.winner else { return }
        // TODO: 서버 저장 로직 그거 끝나면 밑에 로직 실행 combine
        coordinator?.finishTournament(
            category: viewModel.category,
            round: 0,
            tournamentNo: winner.thisWeekTournamentNo)
    }
}
