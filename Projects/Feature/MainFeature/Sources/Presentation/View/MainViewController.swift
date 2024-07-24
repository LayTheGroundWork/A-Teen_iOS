//
//  MainViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol MainViewControllerCoordinator: AnyObject {
    func didSelectTodayTeenImage(
        frame: CGRect,
        todayTeen: TodayTeen)
    func didSelectTodayTeenChattingButton()
    func didSelectMenuButton(popoverPosition: CGRect)
    func didSelectAboutATeenCell(tag: TabTag)
    func didSelectTournamentImage(collectionView: UICollectionView, indexPath: IndexPath)
    func didSelectTournamentMoreButton()
    func didSelectAnotherTeenCell(
        frame: CGRect,
        todayTeen: TodayTeen)
}

public final class MainViewController: UIViewController {
    private var viewModel: MainViewModel
    private weak var coordinator: MainViewControllerCoordinator?
    
    // MARK: - Public properties
    lazy var tableView: UITableView = {
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
    // MARK: - Private properties
    
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
        configUserInterface()
        configLayout()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTableView(_:)),
                                               name: .completeLogin,
                                               object: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.titleView =  CustomNaviView(frame: CGRect(x: 0, y: 0, width: ViewValues.width, height: 40))
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground

        //테이블 뷰
        self.view.addSubview(tableView)
    }
    
    private func configLayout() {
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    // MARK: - Actions
    @objc private func updateTableView(_ notification: Notification) {
        print("!23")
        tableView.reloadData()
    }
}

// MARK: - Extensions here
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
            cell.setCell(teen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
            
            cell.chatButtonAction = { [weak self] in
                guard let self = self else { return }
                self.coordinator?.didSelectTodayTeenChattingButton()
            }
            
            cell.heartButtonAction = { [weak self] in
                guard let self = self else { return }
                self.viewModel.didSelectTodayTeenHeartButton()
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
            return viewModel.todayTeenList.count
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
            guard let cellClicked = tableView.cellForRow(at: indexPath),
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
                todayTeen: viewModel.getTodayTeenItemMainViewModel(row: indexPath.row))
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 187 + ViewValues.todayTeenImageHeight
        case 1:
            return 369
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
}
