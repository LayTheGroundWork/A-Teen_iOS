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
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "나의 취미는 뭔가요?",
        "내가 좋아하는 것은 뭔가요?"
    ]
    
    var questionList: [Question] = []
    var changeQuestionList: [Question] = []
    
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
