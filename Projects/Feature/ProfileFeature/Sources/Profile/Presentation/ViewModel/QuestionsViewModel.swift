//
//  QuestionsViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common

enum SaveError {
    case notChange, textNil
}

public class QuestionsViewModel {
    let sampleQuestionList: [String] = [
        "내가 사는 곳은 어딘가요?",
        "나의 취미는 뭔가요?",
        "나는 누구인가요?",
        "질문거리가 생각이 안나요",
        "내가 좋아하는 것은 뭔가요?",
        "허허",
        "하하",
        "호호",
        "후후",
        "긴거 실험용입니다~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    ]
    
    var questionList: [Question]
    var changeQuestionList: [Question] = []
    
    public init(questionList: [Question]) {
        self.questionList = questionList
        self.changeQuestionList = questionList
    }
}

extension QuestionsViewModel {
    func checkChangeQuestion() -> Bool {
        if questionList == changeQuestionList {
            return true
        }
        
        for questionList in changeQuestionList {
            if questionList.text == AppLocalized.textViewPlaceHolder {
                return true
            }
        }
        return false
    }
    
    func saveChangeValue(completion: @escaping(Bool, SaveError?) -> Void) {
        if questionList != changeQuestionList {
            if changeQuestionList.contains(where: { $0.text == "" }) {
                completion(false, .textNil)
            } else {
                //TODO: 서버 저장 로직
                completion(true, nil)
            }
        } else {
            completion(false, .notChange)
        }
    }
}
