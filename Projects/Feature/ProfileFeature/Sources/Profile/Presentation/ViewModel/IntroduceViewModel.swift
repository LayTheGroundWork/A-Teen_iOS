//
//  IntroduceViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public class IntroduceViewModel {
    var myMbti: [String]
    var myWriting: String
    var changeMbti: [String] = []
    var changeWriting: String = ""
    
    let mbtiExplain: [(String, String)] = [
        ("E", "외향형"),
        ("I", "내향형"),
        ("S", "직관형"),
        ("N", "감각형"),
        ("T", "사고형"),
        ("F", "감정형"),
        ("J", "판단형 (체계적)"),
        ("P", "인식형 (융통성)")
    ]
    
    public init(
        myMbti: [String],
        myWriting: String
    ) {
        self.myMbti = myMbti
        self.myWriting = myWriting
        
        self.changeMbti = myMbti
        self.changeWriting = myWriting
    }
}

extension IntroduceViewModel {
    func changeMyMbti(index: Int, completion: (Int) -> Void) {
        var clearIndex = -1
        switch index {
        case 0:
            changeMbti[0] = mbtiExplain[index].0
            clearIndex = 1
        case 1:
            changeMbti[0] = mbtiExplain[index].0
            clearIndex = 0
        case 2:
            changeMbti[1] = mbtiExplain[index].0
            clearIndex = 3
        case 3:
            changeMbti[1] = mbtiExplain[index].0
            clearIndex = 2
        case 4:
            changeMbti[2] = mbtiExplain[index].0
            clearIndex = 5
        case 5:
            changeMbti[2] = mbtiExplain[index].0
            clearIndex = 4
        case 6:
            changeMbti[3] = mbtiExplain[index].0
            clearIndex = 7
        case 7:
            changeMbti[3] = mbtiExplain[index].0
            clearIndex = 6
        default:
            break
        }
        completion(clearIndex)
    }
    
    func checkChangeIntroduce() -> Bool {
        if myMbti != changeMbti || myWriting != changeWriting {
            return true
        }
        return false
    }
    
    func saveChangeValue(completion: @escaping() -> Void) {
        if myMbti != changeMbti || myWriting != changeWriting {
            //TODO: 서버 저장 로직(mbti 완성 안됬을떄랑 소개글 비었을때 생갹해야됨)
            completion()
        }
    }
}
