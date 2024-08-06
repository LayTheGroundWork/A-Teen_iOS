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

    private lazy var categoryCollectionView: UICollectionView = {
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.todaysTeen
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var teenCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.itemSize = CGSize(width: ViewValues.todayTeenImageWidth, height: ViewValues.todayTeenImageHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    private lazy var grayLine: UIView = {
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
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
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

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
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
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch collectionView {
        case self.categoryCollectionView:
            // 선택 시, 왼쪽에 맞게 카테고리 셀 이동 로직
            if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                let cellFrame = attributes.frame
                var targetOffset = cellFrame.origin.x - 16  // Inset: 16
                // 컬렉션 뷰의 최대 offset
                let maxOffset = collectionView.contentSize.width - collectionView.bounds.width
                // 마지막 셀이 보이면, 왼쪽에 고정되지 않도록 하는 로직
                if targetOffset > maxOffset {
                    targetOffset = maxOffset
                }
                // offset 조정: 0보다 작을 수 없음
                let newOffset = max(0, targetOffset)
                // offset 설정
                collectionView.setContentOffset(
                    CGPoint(x: newOffset, y: 0),
                    animated: true
                )
            }
            //
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

extension TodayTeenTableViewCell: UICollectionViewDelegateFlowLayout {
    // 페이징 로직
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        // 셀 크기
        let cellWidth = ViewValues.todayTeenImageWidth + 16
        // 현재 페이지 위치
        let approxPage = scrollView.contentOffset.x / cellWidth
        // 스크롤 속도
        let speed = velocity.x
        // 스크롤 속도 고려한, 실제 페이지 위치
        let currentPage: CGFloat
        // currentPage 계산
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        // 속도 0일 경우, 페이지 offset 설정
        guard speed != 0
        else {
            targetContentOffset.pointee = CGPoint(
                x: (currentPage * cellWidth) - scrollView.contentInset.left,
                y: scrollView.contentInset.top)
            return
        }
        // currentPage 에서 속도와 방향에 맞춰 다음 페이지 결정
        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)
        // 페이징 임계값 조정
        let velocityThresholdPerPage: CGFloat = 2.0
        // 임계값과 속도를 계산하여 다음 페이지 결정
        let increment = speed / velocityThresholdPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        // 최종 페이지 offset 설정
        targetContentOffset.pointee = CGPoint(
            x: (nextPage * cellWidth) - scrollView.contentInset.left,
            y: scrollView.contentInset.top)
    }
}

extension TodayTeenTableViewCell: Reusable { }
