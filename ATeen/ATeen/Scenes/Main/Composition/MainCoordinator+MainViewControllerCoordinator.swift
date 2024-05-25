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
        print("ChattingButton")
    }
    
    func didSelectAboutATeenCell(tag: Int) {
        switch tag {
        case 0:
            print("Teen")
            
        case 1:
            print("토너먼트")
            
        case 2:
            print("채팅")
            
        case 3:
            print("나만의 Teen")
            
        default:
            print("break")
            break
        }
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
