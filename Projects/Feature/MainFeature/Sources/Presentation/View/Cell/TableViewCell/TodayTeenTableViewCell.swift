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
    
    // MARK: - Private properties
    private var currentTeenIndexPath: IndexPath = .init(row: 0, section: 0)
    private var teenCollectionViewAutoScrollTimer: Timer?
    
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
        view.backgroundColor = DesignSystemAsset.gray04.color
        return view
    }()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerDelegate()
        configUserInterface()
        configLayout()
        // 유저 카드 셀 자동 페이징 시작
        startAutoScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func registerDelegate(){
        self.teenCollectionView.dataSource = self
        self.teenCollectionView.delegate = self
        self.teenCollectionView.register(TeenCollectionViewCell.self, forCellWithReuseIdentifier: TeenCollectionViewCell.reuseIdentifier)
    }
    
    private func configUserInterface() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(teenCollectionView)
        contentView.addSubview(grayLine)
    }
    
    private func configLayout() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
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
    
    // 자동 스크롤 시작
    func startAutoScroll() {
        teenCollectionViewAutoScrollTimer?.invalidate() // 중복 실행 방지
        teenCollectionViewAutoScrollTimer = Timer.scheduledTimer(
            timeInterval: 4.0,
            target: self,
            selector: #selector(scrollToNextItem),
            userInfo: nil,
            repeats: true
        )
    }
    
    // 자동 스크롤 정지
    private func stopAutoScroll() {
        teenCollectionViewAutoScrollTimer?.invalidate()
        teenCollectionViewAutoScrollTimer = nil
    }
    
    // 자동 스크롤 : 다음 cell 로 페이징 스크롤
    @objc private func scrollToNextItem() {
        var nextItem = currentTeenIndexPath.item + 1
        if nextItem >= viewModel.todayTeenList.count {
            nextItem = 0
        }
        currentTeenIndexPath = IndexPath(item: nextItem,
                                         section: currentTeenIndexPath.section)
        self.teenCollectionView.scrollToItem(at: currentTeenIndexPath,
                                             at: .centeredHorizontally,
                                             animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension TodayTeenTableViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
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
            stopAutoScroll()
            self.delegate?.didSelectTodayTeenChattingButton()
        }
        
        cell.heartButtonAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.didSelectTodayTeenHeartButton()
        }
        
        cell.menuButtonAction = { [weak self] in
            guard let self = self else { return }
            stopAutoScroll()
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
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.todayTeenList.count
    }
}

// MARK: - UICollectionViewDelegate
extension TodayTeenTableViewCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cellClicked = collectionView.cellForItem(at: indexPath),
              let frame = cellClicked.superview?.convert(cellClicked.frame, to: nil)
        else { return }
        stopAutoScroll()
        delegate?.didSelectTodayTeenImage(
            frame: frame,
            todayTeen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
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
        let currentPage = scrollView.contentOffset.x / cellWidth
        // 스크롤 속도
        let speed = velocity.x
        // 스크롤 속도 고려한, 실제 페이지 위치
        var nextPage: CGFloat = currentPage
        // nextPage 계산
        if speed < 0 {
            nextPage = ceil(currentPage - 1)
        } else if speed > 0 {
            nextPage = floor(currentPage + 1)
        } else {
            nextPage = round(currentPage)
        }
        // 맨 앞
        if nextPage <= 0 {
            nextPage = 0
        }
        // 맨 뒤
        if Int(nextPage) >= viewModel.todayTeenList.count {
            nextPage -= 1
        }
        // 현재 페이지 IndexPath 설정
        currentTeenIndexPath = IndexPath(item: Int(nextPage),
                                         section: currentTeenIndexPath.section)
        // 최종 페이지 offset 설정
        targetContentOffset.pointee = CGPoint(
            x: (nextPage * cellWidth) - scrollView.contentInset.left,
            y: scrollView.contentInset.top)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startAutoScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startAutoScroll()
    }
}

extension TodayTeenTableViewCell: Reusable { }
