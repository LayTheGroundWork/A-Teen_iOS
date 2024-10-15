//
//  QuestionsViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain

enum SaveError {
    case notChange, textNil
}

public class QuestionsViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(MyPageUseCase.self)
    public var useCase: MyPageUseCase
    
    let sampleQuestionList: [String] = [
        "ONE",
        "TWO",
        "THREE",
        "FOUR",
        "FIVE"
    ]
    
    var user: MyPageData
    var changeQuestionList: [QuestionData] = []
    
    public init(user: MyPageData) {
        self.user = user
        self.changeQuestionList = user.questions
    }
}

extension QuestionsViewModel {
    func checkChangeQuestion() -> Bool {
        if user.questions == changeQuestionList {
            return true
        }
        
        for questionList in changeQuestionList {
            if questionList.answer == AppLocalized.textViewPlaceHolder {
                return true
            }
        }
        return false
    }
    
    func saveChangeValue(completion: @escaping(Bool, SaveError?) -> Void) {
        guard let token = auth.getAccessToken(),
            user.questions != changeQuestionList else {
            completion(false, .notChange)
            return
        }
        
        if changeQuestionList.contains(where: { $0.answer == "" }) {
            completion(false, .textNil)
        } else {
            useCase.editMyPage(
                request: .init(
                    authorization: token,
                    nickName: user.nickName,
                    schoolData: .init(
                        schoolName: user.schoolName,
                        schoolLocation: user.location),
                    snsPlatform: user.snsPlatform,
                    mbti: user.mbti,
                    introduction: user.introduction,
                    questions: changeQuestionList)
            ) { data in
                if let _ = data {
                    self.user.questions = self.changeQuestionList
                    completion(true, nil)
                }
            }
        }
    }
}
