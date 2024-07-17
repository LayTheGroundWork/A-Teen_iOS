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
    var myMbti: [String] = Array(repeating: "", count: 4)   //나중엔 서버에 있는 값 넣기
    
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
    
    func changeMyMbti(index: Int, completion: (Int) -> Void) {
        var clearIndex = -1
        switch index {
        case 0:
            myMbti[0] = mbtiExplain[index].0
            clearIndex = 1
        case 1:
            myMbti[0] = mbtiExplain[index].0
            clearIndex = 0
        case 2:
            myMbti[1] = mbtiExplain[index].0
            clearIndex = 3
        case 3:
            myMbti[1] = mbtiExplain[index].0
            clearIndex = 2
        case 4:
            myMbti[2] = mbtiExplain[index].0
            clearIndex = 5
        case 5:
            myMbti[2] = mbtiExplain[index].0
            clearIndex = 4
        case 6:
            myMbti[3] = mbtiExplain[index].0
            clearIndex = 7
        case 7:
            myMbti[3] = mbtiExplain[index].0
            clearIndex = 6
        default:
            break
        }
        completion(clearIndex)
    }
}
