//
//  TeenViewController.swift
//  ATeen
//
//  Created by 강치우 on 7/21/24.
//

import DesignSystem
import SnapKit

import UIKit

public protocol TeenViewControllerCoordinator: AnyObject {
    func didSelectTeenCategory()
    func configTabbarState(view: TeenFeatureViewNames)
}

public final class TeenViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private var viewModel: TeenViewModel
    private weak var coordinator: TeenViewControllerCoordinator?
    
    private let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    private let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    private let cellId = "cell id"
    
    // TODO: 뷰모델 값으로 변경해야함
    private let imageNames = ["pic1", "pic2", "pic3", "pic4"]
    
    private let labels = ["투표 수가 많은\nTEEN", "최근 가입한\nTEEN", "주간 인기\nTEEN", "대회에 참여한\nTEEN"]
    
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
        titleLabel.text = "TEEN"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        // 행간 조절
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5

        let attributedText = NSAttributedString(
            string: "친구들의 프로필을\n구경해보세요!",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        label.attributedText = attributedText
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "오늘의 TEEN"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomPagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init(
        viewModel: TeenViewModel,
        coordinator: TeenViewControllerCoordinator?
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
//        setButtonActions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .teen)
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configLayout() {
        setupTableHeaderView()
        registerCollectionViewCells()
    }
    
    private func setupTableHeaderView() {
        view.addSubview(heroImageView)
        view.addSubview(subTitleLabel)
        view.addSubview(collectionView)
        
        heroImageView.addSubview(titleLabel)
        heroImageView.addSubview(textLabel)
        
        heroImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(303)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(heroImageView.snp.top).offset(60)
            make.leading.equalTo(heroImageView).offset(16)
            make.height.equalTo(30)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(heroImageView).offset(16)
            make.top.equalTo(heroImageView.snp.bottom).offset(-93)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(heroImageView.snp.bottom).offset(55)
            make.leading.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(cellWidth)
        }
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(CustomTeenCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
//    private func setButtonActions() {
//        teenButton.addTarget(self, action: #selector(selectTeenButton(_:)), for: .touchUpInside)
//    }
    
    // MARK: - Actions
    private func buttonTapped(at index: Int) {
        print("\(index)번째 버튼 눌렀당")
    }
    
    @objc private func selectTeenButton(_ sender: UIButton) {
        self.coordinator?.didSelectTeenCategory()
    }
 
}

// MARK: - Extensions here
extension TeenViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomTeenCollectionViewCell
        let imageName = imageNames[indexPath.item]
        let label = labels[indexPath.item]
        cell.configure(with: UIImage(named: imageName), text: label, buttonAction: { [weak self] in
            self?.buttonTapped(at: indexPath.item)
        })
        return cell
    }
}

extension TeenViewController: UIScrollViewDelegate {
    // 상단 스크롤 막기
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}

