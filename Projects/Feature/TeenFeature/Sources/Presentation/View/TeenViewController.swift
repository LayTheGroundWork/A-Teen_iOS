//
//  TeenViewController.swift
//  ATeen
//
//  Created by 강치우 on 7/21/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import SnapKit

import UIKit

public protocol TeenViewControllerCoordinator: AnyObject {
    func didSelectTeenCategory(label: String)
    func configTabbarState(view: TeenFeatureViewNames)
}

public final class TeenViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private var viewModel: TeenViewModel
    private weak var coordinator: TeenViewControllerCoordinator?
    
    private let cellId = "cell id"
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = DesignSystemAsset.mainColor.color
        imageView.layer.cornerRadius = ViewValues.defaultRadius
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = AppLocalized.teenTitle
        titleLabel.textColor = .white
        titleLabel.font = UIFont.customFont(forTextStyle: .title3,
                                            weight: .bold)
        return titleLabel
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        // 행간 조절
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5

        let attributedText = NSAttributedString(
            string: AppLocalized.teenTextLabel,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        label.attributedText = attributedText
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = AppLocalized.teenSubTitleLabel
        titleLabel.textColor = .black
        titleLabel.font = UIFont.customFont(forTextStyle: .title3,
                                            weight: .bold)
        return titleLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomPagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: 146, height: 163)
        layout.minimumLineSpacing = ViewValues.teenCellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var pageControl: CustomPageControlView = {
        let pageControl = CustomPageControlView(dotWidth: 44, dotHeight: 5)
        pageControl.pages = (viewModel.imageNames.count + 3) / 4 // 4개 단위로 페이지 설정
        return pageControl
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
        collectionView.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .teen)
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        navigationItem.title = nil
    }
    
    private func configLayout() {
        setupTableHeaderView()
        registerCollectionViewCells()
    }
    
    private func setupTableHeaderView() {
        view.addSubview(heroImageView)
        view.addSubview(subTitleLabel)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
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
            make.top.equalTo(subTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(337)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(CustomTeenCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: - Actions
    @objc private func buttonTapped(at index: Int) {
        let selectedLabel = viewModel.labels[index]
        self.coordinator?.didSelectTeenCategory(label: selectedLabel)
    }
}

// MARK: - Extensions here
extension TeenViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageNames.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomTeenCollectionViewCell
        let image = viewModel.imageNames[indexPath.item]
        let label = viewModel.labels[indexPath.item]
        cell.configure(with: image, text: label, buttonAction: { [weak self] in
            self?.buttonTapped(at: indexPath.item)
        })
        return cell
    }
}

extension TeenViewController: UICollectionViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updatePageControl()
    }
    
    private func updatePageControl() {
        let pageWidth = collectionView.frame.size.width
        let currentOffset = collectionView.contentOffset.x
        let page = Int((currentOffset + pageWidth / 2) / pageWidth)
        pageControl.selectedPage = page
    }
}

