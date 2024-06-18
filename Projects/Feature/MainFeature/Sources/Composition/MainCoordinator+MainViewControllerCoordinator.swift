//
//  MainCoordinator+MainViewControllerCoordinator
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import Common
import FeatureDependency
import UIKit

extension MainCoordinator: MainViewControllerCoordinator {
    public func didSelectTodayTeenImage(
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        let profileDetailCoordinator = coordinatorProvider.moveToProfileDetailCoordinator(
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
    
    public func didSelectTodayTeenChattingButton() {
        delegate?.didSelectChattingButton()
    }
    
    public func didSelectMenuButton(popoverPosition: CGRect) {
        let reportPopoverCoordinator = factory.makeReportPopoverCoordinator(
            navigation: navigation,
            popoverPosition: popoverPosition,
            delegate: self)
        addChildCoordinatorStart(reportPopoverCoordinator)
    }
    
    public func didSelectAboutATeenCell(tag: TabTag) {
        delegate?.didSelectAboutATeenCell(tag: tag)
    }
    
    public func didSelectTournamentImage(collectionView: UICollectionView, indexPath: IndexPath) {
        print("clickedTournamentImage: \(indexPath.row)")
    }
    
    public func didSelectTournamentMoreButton() {
        print("MoreButton")
    }
    
    public func didSelectAnotherTeenCell(
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        let profileDetailCoordinator = coordinatorProvider.moveToProfileDetailCoordinator(
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