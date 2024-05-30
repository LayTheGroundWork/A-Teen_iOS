//
//  ViewValues.swift
//  ATeen
//
//  Created by 최동호 on 5/27/24.
//

import UIKit

struct ViewValues {
    // MARK: - Spacing
    static let defaultSpacing: CGFloat = 16
    
    // MARK: - Padding
    static let defaultPadding = 16
    
    // MARK: - Width / Height
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let halfHeight = height / 2
    
    static let todayTeenImageWidth = width - 50
    static let todayTeenImageHeight = todayTeenImageWidth * 1.16
    
    static let anotherTeenImageHeight = (width - 32) * 1.16
    
    static let questionWidth = width - 31
    static let questionHeight = width - 62
    
    static let bottomVoteButtonWidth = (width - 48) / 2
    static let bottomSmallButtonWidth = (bottomVoteButtonWidth - 16) / 2
    
    static let signUpNextButtonWidth = width * 0.32
    static let signUpNextButtonHeight = 50

    static let tabBarHegith = 80
    
    static let defaultButtonSize = 24
    
    static let componentPickerWidth = width / 5
    static let componentPickerHight = componentPickerWidth * 0.72
    
    // MARK: - CornerRadius
    static let defaultRadius: CGFloat = 20
    
    // MARK: - Progress
    static let signUpProgress: Float = 0.2
    
}
