//
//  TournamentTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import Common
import DesignSystem
import UIKit

class TournamentTableViewCell: UITableViewCell {
    
    let categoryArr: [TournamentCategory] = [
        TournamentCategory(title: "운동", image: "exercise"),
        TournamentCategory(title: "스터디", image: "study"),
        TournamentCategory(title: "뷰티", image: "exercise"),
        TournamentCategory(title: "요리", image: "exercise"),
        TournamentCategory(title: "춤", image: "exercise"),
        TournamentCategory(title: "노래", image: "exercise")
    ]
    
    weak var delegate: MainViewControllerCoordinator?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.runningTournament
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppLocalized.showMoreButton, for: .normal)
        button.setTitleColor(DesignSystemAsset.grayButtonColor.color, for: .normal)
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        button.addTarget(self, action: #selector(clickMoreButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = 204
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ViewValues.defaultSpacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: width, height: 213)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.grayLineColor.color
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerDelegate()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(grayLine)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(148)
            make.height.equalTo(24)
        }
        
        self.moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.titleLabel)
            make.width.equalTo(34)
            make.height.equalTo(16)
        }
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(213)
        }
        
        self.grayLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.categoryCollectionView.snp.bottom).offset(46)
            make.height.equalTo(7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func registerDelegate(){
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.register(CategoryTournamentCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTournamentCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource
extension TournamentTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTournamentCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryTournamentCollectionViewCell else { return UICollectionViewCell() }
        cell.setUI(category: categoryArr[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryArr.count
    }
}

// MARK: - UICollectionViewDelegate
extension TournamentTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTournamentImage(collectionView: collectionView, indexPath: indexPath)
    }
}

// MARK: - Action
extension TournamentTableViewCell {
    @objc func clickMoreButton(_ sender: UIButton) {
        delegate?.didSelectTournamentMoreButton()
    }
}

extension TournamentTableViewCell: Reusable { }
