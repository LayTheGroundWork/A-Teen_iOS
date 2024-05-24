//
//  MainFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol MainFactory {
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController
    func makeProfileDetailViewController(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        todayTeen: TodayTeen
    ) -> UIViewController
}

struct MainFactoryImp: MainFactory {
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {
        let viewModel = MainViewModel()
        let controller = MainViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.navigationItem.titleView =  CustomNaviView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        return controller
    }
    
    func makeProfileDetailViewController(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        todayTeen: TodayTeen
    ) -> UIViewController {
        guard let cellClicked = collectionView.cellForItem(at: indexPath),
              let frame = cellClicked.superview?.convert(cellClicked.frame, to: nil)
        else {
            return UINavigationController()
        }
        let controller = ProfileDetailViewController()
        controller.modalPresentationStyle = .overCurrentContext
        controller.frame = frame
        controller.todayTeen = todayTeen
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .overCurrentContext
        navigation.view.backgroundColor = .clear
        return navigation
    }
}
