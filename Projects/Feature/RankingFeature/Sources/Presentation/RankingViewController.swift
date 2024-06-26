//
//  RanKingViewController.swift
//  week4_ciu
//
//  Created by 강치우 on 6/13/24.
//

import Common
import DesignSystem
import UIKit

final class RankingViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let sectionTitles: [String] = ["전체", "뷰티", "운동", "요리", "춤", "노래"]
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = DesignSystemAsset.mainColor.color
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //    private lazy var titleLabel: UILabel = {
    //        let titleLabel = UILabel()
    //        titleLabel.text = "Ranking"
    //        titleLabel.textColor = .white
    //        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    //        return titleLabel
    //    }()
    //
    //    private lazy var searchButton: UIButton = {
    //        let searchButton = UIButton(type: .system)
    //        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    //        searchButton.tintColor = .white
    //        return searchButton
    //    }()
    //
    //    private lazy var bellButton: UIButton = {
    //        let searchButton = UIButton(type: .system)
    //        searchButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
    //        searchButton.tintColor = .white
    //        return searchButton
    //    }()
    
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
        return table
    }()
    
    private lazy var categoryButtons: [UIButton] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        setupTableHeaderView()
        setupCategoryButtons()
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.titleView =  CustomRankingNaviView(frame: CGRect(x: 0, y: 0, width: ViewValues.width, height: 40))
    }
    
    // MARK: - Helpers
    private func setupTableHeaderView() {
        let headerView = UIView()
        headerView.addSubview(heroImageView)
        //        headerView.addSubview(titleLabel)
        //        headerView.addSubview(searchButton)
        //        headerView.addSubview(bellButton)
        headerView.addSubview(textLabel)
        headerView.addSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryStackView)
        
        heroImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(303)
        }
        
        //        titleLabel.snp.makeConstraints { make in
        //            make.top.equalTo(heroImageView.snp.top).offset(70)
        //            make.leading.equalTo(heroImageView).offset(16)
        //        }
        //
        //        searchButton.snp.makeConstraints { make in
        //            make.top.equalTo(heroImageView.snp.top).offset(70)
        //            make.trailing.equalTo(bellButton).offset(-40)
        //            make.height.equalTo(24)
        //        }
        //
        //        bellButton.snp.makeConstraints { make in
        //            make.top.equalTo(heroImageView.snp.top).offset(70)
        //            make.trailing.equalTo(heroImageView).offset(-16)
        //            make.height.equalTo(24)
        //        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(heroImageView).offset(16)
            make.top.equalTo(heroImageView.snp.bottom).offset(-69)
        }
        
        categoryScrollView.snp.makeConstraints { make in
            make.top.equalTo(heroImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        categoryStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 303 + 60 + 40)
        homeFeedTable.tableHeaderView = headerView
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
    
    // MARK: - Actions
    
}

// MARK: - Extensions here
extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingSectorTableViewCell.reuseIdentifier, for: indexPath) as? RankingSectorTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 242
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    // MARK: 폰트 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

class CustomRankingNaviView: UIView {
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Ranking"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    private lazy var searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        return searchButton
    }()
    
    private lazy var bellButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        searchButton.tintColor = .white
        return searchButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomRankingNaviView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(titleLabel)
        self.addSubview(searchButton)
        self.addSubview(bellButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        
        self.searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        self.bellButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.searchButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}

