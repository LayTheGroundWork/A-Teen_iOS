//
//  ViewValues.swift
//  ATeen
//
//  Created by 최동호 on 5/27/24.
//

import UIKit

public struct ViewValues {
    // MARK: - Spacing
    public static let defaultSpacing: CGFloat = 16
    
    // MARK: - Padding
    public static let defaultPadding = 16
    
    // MARK: - Width / Height
    public static let width = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    public static let halfHeight = height / 2
    public static let phoneNumberCollectionViewHeight = height * 0.8
    
    public static let todayTeenImageWidth = width - 50
    public static let todayTeenImageHeight = todayTeenImageWidth * 1.16
    
    public static let anotherTeenImageHeight = (width - 32) * 1.16
    
    public static let questionWidth = width - 31
    public static let questionHeight = width - 62
    
    public static let bottomVoteButtonWidth = (width - 48) / 2
    public static let bottomSmallButtonWidth = (bottomVoteButtonWidth - 16) / 2
    
    public static let signUpNextButtonWidth = width * 0.32
    public static let signUpNextButtonHeight = 50

    public static let tabBarHegith = 80
    
    public static let defaultButtonSize = 24
    
    public static let componentPickerWidth = width / 5
    public static let componentPickerHight = componentPickerWidth * 0.72
    
    // MARK: - CornerRadius
    public static let defaultRadius: CGFloat = 20
    
    // MARK: - Progress
    public static let signUpProgress: Float = 0.2
    
}