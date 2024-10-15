//
//  EditUserNameViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import Foundation

public class EditUserNameViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(MyPageUseCase.self)
    public var useCase: MyPageUseCase
    
    var user: MyPageData
    var changeUserName: String
    
    public init(user: MyPageData) {
        self.user = user
        self.changeUserName = user.nickName
    }
}

extension EditUserNameViewModel {
    func checkChangeUserName(text: String) -> Bool {
        changeUserName = text
        
        if checkRegex(text),
           text.count >= 2,
           text.count <= 8,
           !isIncompleteKoreanWord(text),
           user.nickName != changeUserName {
            return true
        } else {
            return false
        }
    }
    
    // 영어 & 한글 & 숫자
    func checkRegex(_ text: String) -> Bool {
        let characterRegex = ATeenRegex.characterAndNumber
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: characterRegex)
        let result = regex.firstMatch(in: text, options: [], range: range) != nil
        return result
    }
    
    /// 불완전한 한글 단어 확인
    /// ex. ㅅㅏ, ㄹㅏㅇ, ㅐㅎ
    func isIncompleteKoreanWord(_ text: String) -> Bool {
        let completeKoreanRegex = ATeenRegex.completeKorean
        let incompleteKoreanRegex = ATeenRegex.incompleteKorean
        
        let completeRegex = try! NSRegularExpression(pattern: completeKoreanRegex)
        let incompleteRegex = try! NSRegularExpression(pattern: incompleteKoreanRegex)
        
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let isCompleteKorean = completeRegex.firstMatch(in: text, options: [], range: range) != nil
        let hasIncompleteKorean = incompleteRegex.firstMatch(in: text, options: [], range: range) != nil
        return !isCompleteKorean && hasIncompleteKorean
    }
    
    func saveChangeValue(completion: @escaping() -> Void) {
        guard let token = auth.getAccessToken() else { return }
        
        useCase.editMyPage(
            request: .init(
                authorization: token,
                nickName: changeUserName,
                schoolData: .init(
                    schoolName: user.schoolName,
                    schoolLocation: user.location),
                snsPlatform: user.snsPlatform,
                mbti: user.mbti,
                introduction: user.introduction,
                questions: user.questions)
        ) { data in
            if let _ = data {
                self.user.nickName = self.changeUserName
                completion()
            }
        }
    }
}
