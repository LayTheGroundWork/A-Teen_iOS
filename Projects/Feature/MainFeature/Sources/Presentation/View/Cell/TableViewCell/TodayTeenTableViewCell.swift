//
//  TodayTeenTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import Common
import DesignSystem
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
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.todaysTeen
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var teenCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.itemSize = CGSize(width: ViewValues.todayTeenImageWidth, height: ViewValues.todayTeenImageHeight)
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
            make.height.equalTo(ViewValues.todayTeenImageHeight)
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
        self.teenCollectionView.register(TeenCollectionViewCell.self, forCellWithReuseIdentifier: TeenCollectionViewCell.reuseIdentifier)
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
                    withReuseIdentifier: TeenCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? TeenCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setCell(teen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
            
            cell.chatButtonAction = { [weak self] in
                guard let self = self else { return }
                self.delegate?.didSelectTodayTeenChattingButton()
            }
            
            cell.heartButtonAction = { [weak self] in
                guard let self = self else { return }
                self.viewModel.didSelectTodayTeenHeartButton()
            }
            
            cell.menuButtonAction = { [weak self] in
                guard let self = self else { return }
                cell.layoutIfNeeded()
                guard let tableViewCell = self.superview,
                      let tableView = tableViewCell.superview,
                      let mainView = tableView.superview,
                      let appView = mainView.superview
                else { return }
                
                let cellPosition = cell.convert(cell.bounds, to: appView)
                let menuButtonPosition = CGRect(
                    x: cellPosition.maxX,
                    y: cellPosition.minY,
                    width: cellPosition.width,
                    height: cellPosition.height)
                self.delegate?.didSelectMenuButton(popoverPosition: menuButtonPosition)
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
            guard let cellClicked = collectionView.cellForItem(at: indexPath),
                  let frame = cellClicked.superview?.convert(cellClicked.frame, to: nil)
            else { return }
            
            delegate?.didSelectTodayTeenImage(
                frame: frame,
                todayTeen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
        default:
            break
        }
    }
}

extension TodayTeenTableViewCell: Reusable { }