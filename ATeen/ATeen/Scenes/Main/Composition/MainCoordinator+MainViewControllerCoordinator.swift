//
//  MainCoordinator+MainViewControllerCoordinator
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import UIKit

extension MainCoordinator: MainViewControllerCoordinator {
    func didSelectTodayTeenImage(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        todayTeen: TodayTeen
    ) {
        delegate?.isHiddenTabbar()
        navigation.present(
            factory.makeProfileDetailViewController(
                collectionView: collectionView,
                indexPath: indexPath,
                todayTeen: todayTeen),
            animated: false)
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
    
    func didSelectAnotherTeenCell(row: Int) {
        print("Select Item: \(row)")
    }
}
