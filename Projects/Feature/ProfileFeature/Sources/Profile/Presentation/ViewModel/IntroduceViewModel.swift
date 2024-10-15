//
//  IntroduceViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import DesignSystem
import Domain
import UIKit

public class IntroduceViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(MyPageUseCase.self)
    public var useCase: MyPageUseCase
    
    
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
    
    var user: MyPageData
    
    var myMbti: [String]
    var myWriting: String
    var changeMbti: [String] = []
    var changeWriting: String = ""
    
    public init(user: MyPageData){
        self.user = user
        self.myMbti = user.mbti?.map { String($0) } ?? ["", "", "", ""]
        self.myWriting = user.introduction ?? ""
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
        guard let token = auth.getAccessToken() else { return }
        
        if myMbti != changeMbti || myWriting != changeWriting {
            let stringMbti = changeMbti.reduce("", +)
            let resultMbti = stringMbti == "" ? nil : stringMbti
            let resultIntroduce = changeWriting == "" ? nil : changeWriting
            useCase.editMyPage(
                request: .init(
                    authorization: token,
                    nickName: user.nickName,
                    schoolData: .init(
                        schoolName: user.schoolName,
                        schoolLocation: user.location),
                    snsPlatform: user.snsPlatform,
                    mbti: resultMbti,
                    introduction: resultIntroduce,
                    questions: user.questions)
            ) { data in
                if let _ = data {
                    self.user.mbti = resultMbti
                    self.user.introduction = resultIntroduce
                    completion()
                }
            }
        }
    }
}
