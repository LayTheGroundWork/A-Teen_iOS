//
//  TodayTeenTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class TodayTeenTableViewCell: UITableViewCell {
    weak var delegate: MainViewControllerCoordinator?
    
    var viewModel: MainViewModel = .init()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = 100
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: width, height: 47)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 인기 Teen"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var teenCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = contentView.frame.width - 50
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: width, height: 360)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayLineColor")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerDelegate()
        
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(teenCollectionView)
        contentView.addSubview(grayLine)
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        self.teenCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(360)
        }
        
        self.grayLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.teenCollectionView.snp.bottom).offset(46)
            make.height.equalTo(7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerDelegate(){
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.register(CategoryTodayCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTodayCollectionViewCell.reuseIdentifier)
        
        self.teenCollectionView.dataSource = self
        self.teenCollectionView.delegate = self
        self.teenCollectionView.register(TodayTeenCollectionViewCell.self, forCellWithReuseIdentifier: TodayTeenCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource
extension TodayTeenTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.categoryCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryTodayCollectionViewCell.reuseIdentifier,
                for: indexPath) as? CategoryTodayCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setButton(category: viewModel.getCategoryItemMainViewModel(row: indexPath.row))
            return cell
            
        case self.teenCollectionView:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TodayTeenCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? TodayTeenCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.delegate = delegate
            cell.setCell(teen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
            
            cell.heartButtonAction = {
                self.viewModel.didSelectTodayTeenHeartButton()
            }
            
            cell.menuButtonAction = {
                self.viewModel.didSelectTodayTeenMenuButton()
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.categoryCollectionView:
            return viewModel.categoryList.count
        case self.teenCollectionView:
            return viewModel.todayTeenList.count
        default:
            return 0
        }
    }
}

// MARK: - UICollectionViewDelegate
extension TodayTeenTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.categoryCollectionView:
            //self.categoryCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            viewModel.didSelectCategoryCell(row: indexPath.row)
            collectionView.reloadData()
            
        case self.teenCollectionView:
            delegate?.didSelectTodayTeenImage(
                collectionView: collectionView,
                indexPath: indexPath,
                todayTeen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
        default:
            break
        }
    }
}

extension TodayTeenTableViewCell: Reusable { }
