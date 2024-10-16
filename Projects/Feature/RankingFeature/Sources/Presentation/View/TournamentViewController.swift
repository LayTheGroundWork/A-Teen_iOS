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

// MARK: - 토너먼트 각 Round 에 맞는 enum
enum TournamentRound: String, CaseIterable {
    case roundOf16 = "16강"
    case roundOf8 = "8강"
    case semifinals = "4강"
    case final = "결승전"
    case end = ""
    
    var matches: Int {
        switch self {
        case .roundOf16:
            return 8
        case .roundOf8:
            return 4
        case .semifinals:
            return 2
        case .final:
            return 1
        case .end:
            return 0
        }
    }
    
    var progress: Float {
        switch self {
        case .roundOf16:
            return 0.125
        case .roundOf8:
            return 0.25
        case .semifinals:
            return 0.5
        case .final:
            return 1
        case .end:
            return 0
        }
    }
}

public protocol TournamentViewControllerCoordinator: AnyObject {
    func quitTournament()
    func finishTournament(sector: String, session: String)
    func openQuitDialog()
    func configTabbarState(view: RankingFeatureViewNames)
}

public final class TournamentViewController: UIViewController {
    let sector: String
    
    // MARK: - Private properties
    private weak var coordinator: TournamentViewControllerCoordinator?

    private var currentRound: TournamentRound = TournamentRound.allCases.first ?? .roundOf16
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkWhiteIcon.image,
                        for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self,
                         action: #selector(didSelectCloseButton(_:)),
                         for: .touchUpInside)

        let label = UILabel()
        label.text = sector
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

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ViewValues.width,
                                 height: ViewValues.height - 80)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.register(TournamentRoundCollectionViewCell.self,
                                forCellWithReuseIdentifier: TournamentRoundCollectionViewCell.reuseIdentifier)
        collectionView.register(TournamentEndCollectionViewCell.self,
                                forCellWithReuseIdentifier: TournamentEndCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        coordinator: TournamentViewControllerCoordinator,
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
        view.backgroundColor = UIColor.black
        
        navigationItem.leftBarButtonItem = closeButton
        
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func didSelectCloseButton(_ sender: UIButton) {
        switch currentRound {
        case .roundOf16, .roundOf8, .semifinals, .final:
            // QuitTournamentDialog 띄우기
            coordinator?.openQuitDialog()
        case .end:
            // 토너먼트 종료
            coordinator?.quitTournament()
        }
    }
    
    private func scrollToPage(at index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: false)
    }
}

// MARK: - Extensions here
extension TournamentViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        1
    }
    
    public func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        // 16강, 8강, 4강, 결승 + 완료 페이지
        TournamentRound.allCases.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 ||
           indexPath.section == 1 ||
           indexPath.section == 2 ||
           indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TournamentRoundCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TournamentRoundCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setProperties(round: currentRound)
            cell.delegate = coordinator
            cell.roundDelegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TournamentEndCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TournamentEndCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setProperties(userName: "김 에스더",
                               school: "서울 중학교",
                               age: 16,
                               image: DesignSystemAsset.whiteGlass.image)
            cell.sector = sector
            cell.delegate = coordinator
            return cell
        }
    }
}

extension TournamentViewController: UICollectionViewDelegate { }

extension TournamentViewController: TournamentRoundCollectionViewCellDelegate {
    public func nextRound() {
        switch currentRound {
        case .roundOf16:
            currentRound = .roundOf8
            scrollToPage(at: 1)
        case .roundOf8:
            currentRound = .semifinals
            scrollToPage(at: 2)
        case .semifinals:
            currentRound = .final
            scrollToPage(at: 3)
        case .final:
            currentRound = .end
            scrollToPage(at: 4)
        case .end:
            break
        }
    }
}
