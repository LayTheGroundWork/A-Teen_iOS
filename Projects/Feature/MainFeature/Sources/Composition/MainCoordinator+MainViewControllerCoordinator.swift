//
//  MainCoordinator+MainViewControllerCoordinator
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension MainCoordinator: MainViewControllerCoordinator {
    public func didSelectTodayTeenImage(
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        let profileDetailCoordinator = coordinatorProvider.makeProfileDetailCoordinator(
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
        let profileDetailCoordinator = coordinatorProvider.makeProfileDetailCoordinator(
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
    
    public func alertTestViewOpen() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: AlertDialogType.twoButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: "안녕",
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .regular),
                dialogMessage: "ㅎㅇ",
                messageColor: .black,
                messageNumberOfLine: 1,
                messageFont: .customFont(forTextStyle: .callout, weight: .regular),
                buttonText: "취소",
                buttonColor: .white,
                secondButtonText: "확인",
                secondButtonColor: DesignSystemAsset.mainColor.color))
        addChildCoordinatorStart(coordinator)
    }
}

extension MainCoordinator: AlertCoordinatorDelegate {
    public func didFinish(selectIndex: Int) {
        navigation.dismiss(animated: false)
        switch selectIndex {
        case 0:
            print("no")
        case 1:
            print("hi")
            let coordinator = factory.makeReportDialogCoordinator(navigation: navigation, delegate: self)
            addChildCoordinatorStart(coordinator)
        default:
            break
        }
    }
}
