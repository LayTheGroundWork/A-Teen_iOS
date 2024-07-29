//
//  CustomPagingCollectionViewLayout.swift
//  TeenFeature
//
//  Created by 강치우 on 7/21/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

class CustomPagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    var velocityThresholdPerPage: CGFloat = 2
    var numberOfItemsPerPage: CGFloat = 1 // 한 번에 넘길 수 있는 페이지 수
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width
        let availableHeight = collectionView.bounds.height
        
        // 가로 세로 2*2
        let itemsPerRow: CGFloat = 2
        let itemsPerColumn: CGFloat = 2
        
        let spacing: CGFloat = 11
        
        let totalSpacingWidth = spacing * (itemsPerRow + 1)
        let totalSpacingHeight = spacing * (itemsPerColumn + 1)
        
        let itemWidth = (availableWidth - totalSpacingWidth) / itemsPerRow
        let itemHeight = (availableHeight - totalSpacingHeight) / itemsPerColumn
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
    }
    
    // MARK: 가로 페이징을 구현하기 위한 가로 좌표값
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat
        
        if scrollDirection == .horizontal {
            pageLength = (self.itemSize.width + self.minimumLineSpacing) * 2
            approxPage = collectionView.contentOffset.x / pageLength
            speed = velocity.x
        } else {
            pageLength = (self.itemSize.height + self.minimumLineSpacing) * 2
            approxPage = collectionView.contentOffset.y / pageLength
            speed = velocity.y
        }
        
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: currentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: currentPage * pageLength)
            }
        }
        
        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)
        
        let increment = speed / velocityThresholdPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        if scrollDirection == .horizontal {
            return CGPoint(x: nextPage * pageLength, y: 0)
        } else {
            return CGPoint(x: 0, y: nextPage * pageLength)
        }
    }
}
