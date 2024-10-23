//
//  MainViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import SnapKit

import Common
import DesignSystem
import Domain
import UIKit

public protocol MainViewControllerCoordinator: AnyObject {
    func didSelectTodayTeenImage(frame: CGRect, todayTeen: UserData, todayTeenFirstImage: UIImage)
    func didSelectTodayTeenChattingButton()
    func didSelectMenuButton(popoverPosition: CGRect)
    func didSelectAboutATeenCell(tag: TabTag)
    func didSelectTournamentImage(collectionView: UICollectionView, indexPath: IndexPath)
    func didSelectTournamentMoreButton()
    func didSelectAnotherTeenCell(frame: CGRect, todayTeen: UserData, todayTeenFirstImage: UIImage)
}

protocol MainViewControllerDelegate: AnyObject {
    func reStartTimer()
}

public final class MainViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: MainViewModel
    private weak var coordinator: MainViewControllerCoordinator?
    
    private var startContentOffset: CGFloat = 0.0
    
    private var naviHeightAnchor: Constraint?
    
    private lazy var customNaviView = CustomNaviView()
    // CustomNaviView(frame: CGRect(x: 0, y: 0, width: ViewValues.width, height: 40))
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryTodayCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTodayCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodayTeenTableViewCell.self, forCellReuseIdentifier: TodayTeenTableViewCell.reuseIdentifier)
        tableView.register(AboutATeenTableViewCell.self, forCellReuseIdentifier: AboutATeenTableViewCell.reuseIdentifier)
        tableView.register(TournamentTableViewCell.self, forCellReuseIdentifier: TournamentTableViewCell.reuseIdentifier)
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.reuseIdentifier)
        tableView.register(TeenTableViewCell.self, forCellReuseIdentifier: TeenTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life Cycle
    init(
        viewModel: MainViewModel,
        coordinator: MainViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.findAllUser { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.configUserInterface()
                self.configLayout()
                
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.updateTableView(_:)),
                                                       name: .completeLogin,
                                                       object: nil)
            }
        }
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = UIColor.systemBackground
        
        self.view.addSubview(customNaviView)
        self.view.addSubview(categoryCollectionView)
        self.view.addSubview(tableView)
    }
    
    private func configLayout() {
        self.customNaviView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            self.naviHeightAnchor = make.height.equalTo(40).constraint
        }
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.customNaviView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(categoryCollectionView.snp.bottom)
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            // 카테고리 선택할 떄
            self.tableView.scrollToRow(
                at: IndexPath(row: 0, section: 0),
                at: .top,
                animated: true)
            
            self.customNaviView.isHidden = false
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .showHideTransitionViews) {
                self.naviHeightAnchor?.update(offset: 40)
                
                self.view.layoutIfNeeded()
            }
            
            for subview in self.tableView.subviews {
                if let cell = subview as? TodayTeenTableViewCell {
                    if cell.teenCollectionView.numberOfItems(inSection: 0) > 0 {
                        cell.teenCollectionView.scrollToItem(
                            at: IndexPath(item: 0, section: 0),
                            at: .centeredHorizontally,
                            animated: true)
                        cell.currentTeenIndexPath = .init(item: 0, section: 0)
                    }
                    
                    cell.teenCollectionView.reloadData()
                    self.tableView.reloadData()
                    
                    if cell.teenCollectionView.numberOfItems(inSection: 0) > 0 {
                        self.reStartTimer()
                    } else {
                        cell.stopAutoScroll()
                    }
                    break
                }
            }
        }
    }
    
    // MARK: - Actions
    @objc private func updateTableView(_ notification: Notification) {
        print("LogOut/LogIn -> Reload Data")
        print(viewModel.auth.isSessionActive)
        
        if viewModel.auth.isSessionActive {
            viewModel.clearTeenList()
            for (index, category) in viewModel.categoryList.enumerated() {
                if category.isSelect {
                    if index == 0 {
                        viewModel.findAllUser { [weak self] in
                            guard let self = self else { return }
                            self.updateUI()
                        }
                    } else {
                        viewModel.findCategoryUser(row: index) { [weak self] in
                            guard let self = self else { return }
                            DispatchQueue.main.async {
                                self.updateUI()
                            }
                        }
                    }
                    break
                }
            }
        }
    }
}

// MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startContentOffset = scrollView.contentOffset.y
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y

        if offsetY > startContentOffset {
            UIView.animate(withDuration: 0.2, delay: 0, options: .showHideTransitionViews) {
                self.naviHeightAnchor?.update(offset: 0)
                self.customNaviView.isHidden = true
                
                self.view.layoutIfNeeded()
            }
        } else {
            self.customNaviView.isHidden = false
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .showHideTransitionViews) {
                self.naviHeightAnchor?.update(offset: 40)
                
                self.view.layoutIfNeeded()
            }
        }
        startContentOffset = 0.0
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: TodayTeenTableViewCell.reuseIdentifier,
                    for: indexPath) as? TodayTeenTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            cell.delegate = coordinator
            cell.viewModel = viewModel
            return cell
            
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: AboutATeenTableViewCell.reuseIdentifier,
                    for: indexPath) as? AboutATeenTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.delegate = coordinator
            return cell
            
        case 2:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: TournamentTableViewCell.reuseIdentifier,
                    for: indexPath) as? TournamentTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.delegate = coordinator
            return cell
            
        case 3:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: HeaderTableViewCell.reuseIdentifier,
                    for: indexPath) as? HeaderTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            return cell
            
        case 4:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: TeenTableViewCell.reuseIdentifier,
                    for: indexPath) as? TeenTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.setCell(teen: viewModel.teenList[indexPath.row])
            
            cell.chatButtonAction = { [weak self] in
                guard let self = self else { return }
                self.coordinator?.didSelectTodayTeenChattingButton()
            }
            
            cell.heartButtonAction = { [weak self] in
                guard let self = self else { return }
                self.viewModel.didSelectTodayTeenHeartButton(row: indexPath.row) {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            
            cell.menuButtonAction = { [weak self] in
                guard let self = self else { return }
                cell.layoutIfNeeded()
                guard let mainView = tableView.superview,
                      let appView = mainView.superview
                else { return }
                
                let cellPosition = cell.convert(cell.bounds, to: appView)
                let menuButtonPosition = CGRect(
                    x: cellPosition.maxX,
                    y: cellPosition.minY,
                    width: cellPosition.width,
                    height: cellPosition.height)
                self.coordinator?.didSelectMenuButton(popoverPosition: menuButtonPosition)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 3:
            return 1
        case 4:
            return viewModel.teenList.count
        default:
            return 0
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 4:
            guard let cellClicked = tableView.cellForRow(at: indexPath) as? TeenTableViewCell,
                  let frame = cellClicked.superview?.convert(
                    CGRect(
                        x: 16,
                        y: cellClicked.frame.origin.y,
                        width: cellClicked.frame.width - 32,
                        height: cellClicked.frame.height),
                    to: nil)
            else { return }
            
            coordinator?.didSelectAnotherTeenCell(
                frame: frame,
                todayTeen: viewModel.teenList[indexPath.row], 
                todayTeenFirstImage: cellClicked.getImage())
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 111 + ViewValues.todayTeenImageHeight
        case 1:
            return 355
        case 2:
            return 358
        case 3:
            return 76
        case 4:
            return ViewValues.anotherTeenImageHeight
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = viewModel.teenList.count - 1
        
        guard indexPath == IndexPath(row: lastRowIndex, section: 4),
              !viewModel.isLoading,
              viewModel.teenList.count == viewModel.currentSize 
        else { return }
        
        self.activityIndicator.startAnimating()
        viewModel.loadMoreData() { [weak self] in
            guard let self = self else { return }
            sleep(2)
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.viewModel.isLoading = false
                self.tableView.reloadData()
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        switch section {
        case 4:
            //나중에 Lottie 넣기
            let footerView = UIView()
            footerView.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            return footerView
        default:
            return nil
        }
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 4:
            return 44
        default:
            return 0
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryTodayCollectionViewCell.reuseIdentifier,
                for: indexPath) as? CategoryTodayCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setButton(category: viewModel.categoryList[indexPath.row])
        return cell
        
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.categoryList.count
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
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
        
        viewModel.didSelectCategoryCell(row: indexPath.row)
        collectionView.reloadData()
        
        if indexPath.row == 0 {
            viewModel.findAllUser { [weak self] in
                guard let self = self else { return }
                self.updateUI()
            }
        } else {
            viewModel.findCategoryUser(row: indexPath.row) { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }
}

extension MainViewController: MainViewControllerDelegate {
    func reStartTimer() {
        for subview in tableView.subviews {
            if let cell = subview as? TodayTeenTableViewCell {
                cell.startAutoScroll()
            }
        }
    }
}
