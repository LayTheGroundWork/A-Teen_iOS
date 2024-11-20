//
//  MainCoordinator+MainViewControllerCoordinator
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import Common
import DesignSystem
import Domain
import FeatureDependency
import UIKit

extension MainCoordinator: MainViewControllerCoordinator {
    public func openLoginSheet() {
        delegate?.openLoginCoordinator()
    }
    
    public func didSelectSearchButton() {
        let searchUserCoordinator = factory.makeSearchUserCoordinator(
            navigation: navigation,
            coordinatorProvider: coordinatorProvider,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(searchUserCoordinator)
    }
    
    public func didSelectTodayTeenImage(
        frame: CGRect,
        todayTeen: User,
        todayTeenFirstImage: UIImage
    ) {
        let profileDetailCoordinator = coordinatorProvider.makeProfileDetailCoordinator(
            delegate: self,
            frame: frame,
            todayTeen: todayTeen, 
            todayTeenFirstImage: todayTeenFirstImage)
        
        addChildCoordinatorStart(profileDetailCoordinator)
        
        navigation.present(
            profileDetailCoordinator.navigation.rootViewController,
            animated: false)
        
        profileDetailCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(profileDetailCoordinator)
        }
    }
    
    public func didSelectMenuButton(popoverPosition: CGRect) {
        let reportPopoverCoordinator = coordinatorProvider.makePopoverCoordinator(
            popoverPosition: popoverPosition,
            delegate: self)
        addChildCoordinatorStart(reportPopoverCoordinator)
        
        navigation.present(
            reportPopoverCoordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func didSelectAboutATeenCell(tag: TabTag) {
        delegate?.didSelectAboutATeenCell(tag: tag)
    }
    
    public func didSelectTournamentImage(indexPath: IndexPath) {
        print("clickedTournamentImage: \(indexPath.row)")
    }
    
    public func didSelectTournamentMoreButton() {
        print("MoreButton")
    }
    
    public func didSelectAnotherTeenCell(
        frame: CGRect,
        todayTeen: User,
        todayTeenFirstImage: UIImage
    ) {
        let profileDetailCoordinator = coordinatorProvider.makeProfileDetailCoordinator(
            delegate: self,
            frame: frame,
            todayTeen: todayTeen, 
            todayTeenFirstImage: todayTeenFirstImage)
        
        addChildCoordinatorStart(profileDetailCoordinator)
        
        navigation.present(
            profileDetailCoordinator.navigation.rootViewController,
            animated: false)
        
        profileDetailCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(profileDetailCoordinator)
        }
    }
}
