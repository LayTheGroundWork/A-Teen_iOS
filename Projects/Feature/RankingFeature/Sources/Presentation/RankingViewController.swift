//
//  RanKingViewController.swift
//  week4_ciu
//
//  Created by 강치우 on 6/13/24.
//

import Common
import DesignSystem
import UIKit

public protocol RankingViewControllerCoordinator: AnyObject {
    func didTapVoteButton(sector: String)
    func didTapRankingCollectionViewCell(sector: String, session: String)
    func configTabbarState(view: RankingFeatureViewNames)
}

public final class RankingViewController: UIViewController {
    // MARK: - Private properties
    private weak var coordinator: RankingViewControllerCoordinator?
    
    private let sectionTitles: [String] = ["전체", "뷰티", "운동", "요리", "춤", "노래"]
    
    private let headerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 303 + 60 + 40)
        return view
    }()
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = DesignSystemAsset.mainColor.color
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Ranking"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "투표해보세요"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    private lazy var homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(RankingSectorTableViewCell.self, forCellReuseIdentifier: RankingSectorTableViewCell.reuseIdentifier)
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.contentInsetAdjustmentBehavior = .never
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        table.tableHeaderView = headerView
        return table
    }()
    
    private lazy var categoryButtons: [UIButton] = []
    
    // MARK: - Life Cycle
    init(
        coordinator: RankingViewControllerCoordinator
    ) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .systemBackground
          
          homeFeedTable.delegate = self
          homeFeedTable.dataSource = self
          
          configUserInterface()
          configLayout()
          setupCategoryButtons()
      }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .ranking)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configUserInterface() {
        view.addSubview(homeFeedTable)
        headerView.addSubview(heroImageView)
        headerView.addSubview(textLabel)
        headerView.addSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryStackView)
        headerView.addSubview(titleLabel)
    }
    
    private func configLayout() {
        categoryScrollView.snp.makeConstraints { make in
            make.top.equalTo(heroImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        categoryStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        homeFeedTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        heroImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(303)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(heroImageView).offset(16)
            make.top.equalTo(heroImageView.snp.bottom).offset(-69)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
    }
    
    private func setupCategoryButtons() {
        for (index, category) in sectionTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.tag = index
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            categoryStackView.addArrangedSubview(button)
            categoryButtons.append(button)
            
            button.snp.makeConstraints { make in
                make.width.equalTo(74.5)
            }
        }
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        for button in categoryButtons {
            if button == sender {
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
}

// MARK: - Extensions here
extension RankingViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingSectorTableViewCell.reuseIdentifier, for: indexPath) as? RankingSectorTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = coordinator
        cell.sector = sectionTitles[indexPath.section]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

extension RankingViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    // MARK: 폰트 설정
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
}

extension RankingViewController: UIScrollViewDelegate {
    // 상단 스크롤 막기
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
