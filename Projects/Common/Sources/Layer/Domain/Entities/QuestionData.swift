//
//  QuestionData.swift
//  Common
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct QuestionData: Codable, Equatable {
    public var question: String
    public var answer: String
    
    public init(
        question: String,
        answer: String
    ) {
        self.question = question
        self.answer = answer
    }
}
