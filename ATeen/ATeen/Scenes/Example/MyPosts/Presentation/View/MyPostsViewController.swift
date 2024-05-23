//
//  MyPostsViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

protocol MyPostsViewControllerCoordinator: AnyObject {
    func didSelectPost(id: Int)
    func didTapAddNewPostButton()
}

final class MyPostsViewController: UICollectionViewController {
    // MARK: - Private properties
    private weak var coordinator: MyPostsViewControllerCoordinator?
    private var counter = 1
    private var exampleLabel: UILabel = UILabel()
    
    // MARK: - Life Cycle
    
    init(
        collectionViewLayout: UICollectionViewLayout,
        coordinator: MyPostsViewControllerCoordinator
    ) {
        self.coordinator = coordinator
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configCollectionView()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        
        let newPostBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addNewPostAction())
        navigationItem.rightBarButtonItem = newPostBarButtonItem
        
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(exampleLabel)
        exampleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exampleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func configCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.backgroundColor = .systemGroupedBackground
    }
    
    // MARK: - Actions
    private func addNewPostAction() -> UIAction {
        return UIAction { [weak self] _ in
            self?.coordinator?.didTapAddNewPostButton()
        }
    }
    
    func updateLabel(title: String) {
        exampleLabel.text = title
        counter = counter + 1
        collectionView.reloadData()
    }
}

// MARK: - Extensions here
extension MyPostsViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        
        //TODO: Move in the same cell
        var configuration = UIListContentConfiguration.cell()
        configuration.text = "hello"
        configuration.secondaryText = "there"
        configuration.image = UIImage(systemName: "photo")
        cell.contentConfiguration = configuration
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        counter
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        coordinator?.didSelectPost(id: indexPath.row)
    }
    
}

