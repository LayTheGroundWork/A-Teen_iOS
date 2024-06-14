//
//  MainCoordinator+MainViewControllerCoordinator
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import UIKit

extension MainCoordinator: MainViewControllerCoordinator {
    func didSelectTodayTeenImage(
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        let profileDetailCoordinator = factory.makeProfileDetailCoordinator(
            delegate: self,
            frame: frame,
            todayTeen: todayTeen)
        
        addChildCoordinatorStart(profileDetailCoordinator)
        
        navigation.present(
            profileDetailCoordinator.navigation.rootViewController,
            animated: false)
        
        profileDetailCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(profileDetailCoordinator)
        }
    }
    
    func didSelectTodayTeenChattingButton() {
        delegate?.didSelectChattingButton()
    }
    
    func didSelectMenuButton(popoverPosition: CGRect) {
        let reportPopoverCoordinator = factory.makeReportPopoverCoordinator(
            navigation: navigation,
            popoverPosition: popoverPosition,
            delegate: self)
        addChildCoordinatorStart(reportPopoverCoordinator)
    }
    
    func didSelectAboutATeenCell(tag: TabTag) {
        delegate?.didSelectAboutATeenCell(tag: tag)
    }
    
    func didSelectTournamentImage(collectionView: UICollectionView, indexPath: IndexPath) {
        print("clickedTournamentImage: \(indexPath.row)")
    }
    
    func didSelectTournamentMoreButton() {
        print("MoreButton")
    }
    
    func didSelectAnotherTeenCell(
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        let profileDetailCoordinator = factory.makeProfileDetailCoordinator(
            delegate: self,
            frame: frame,
            todayTeen: todayTeen)
        
        addChildCoordinatorStart(profileDetailCoordinator)
        
        navigation.present(
            profileDetailCoordinator.navigation.rootViewController,
            animated: false)
        
        profileDetailCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(profileDetailCoordinator)
        }
    }
}
