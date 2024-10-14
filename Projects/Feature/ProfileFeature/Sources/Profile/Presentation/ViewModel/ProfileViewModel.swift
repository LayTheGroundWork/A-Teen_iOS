//
//  ProfileViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import DesignSystem
import UIKit

public class ProfileViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(MyPageUseCase.self)
    public var useCase: MyPageUseCase
    
    var user: MyPageData = .init(
        id: 0,
        profileImages: [],
        likeCount: 15,
        nickName: "철수",
        uniqueId: "",
        mbti: nil,
        introduction: nil,
        birthDay: "1997-09-01",
        location: "서울",
        schoolName: "서울고등학교",
        snsPlatform: nil,
        category: "",
        questions: [])
    
    var userBadge: [Badge] = [
        .init(type: .badge1, explain: "처음 가입하면 이 배지를 획득할 수 있어요\n새로운 시작을 축하해요!"),
        .init(type: .badge2, explain: "프로필 사진, 기본 정보, 10문 10답을 모두 작성하면 첫인상이 확 달라질 거예요!"),
        .init(type: .badge3, explain: "첫 대표 사진을 올려보세요\n당신의 매력을 보여줄 차례예요!"),
        .init(type: .badge4, explain: "첫 좋아요를 받았어요\n첫걸음이니까 앞으로 더 기대해봐요!"),
        .init(type: .badge5, explain: "각 주제별 16강 토너먼트에 처음 진출하셨군요\n더 높게 올라가보세요!"),
        .init(type: .badge6, explain: "좋아요 100개 돌파 인기 상승 중이네요!"),
        .init(type: .badge7, explain: "당신이 챔피언! 축하드려요!"),
        .init(type: .badge8, explain: "채팅으로 30명 이상과 소통하며 진정한 소통 마스터가 되었네요!"),
        .init(type: .badge9, explain: "첫 채팅 메시지를 보내봤나요?\n 누군가에게 첫인사를 건네는 건 언제나 설레죠!"),
        .init(type: .badge10, explain: "당신이 진정한 인기스타!"),
        .init(type: .badge11, explain: "4주 연속 토너먼트에 참여한 끈기를 보여주셨군요\n꾸준함이 빛을 발할 거예요!"),
        .init(type: .badge12, explain: "다른 사람에게 좋아요 50번 넘게 주셨네요\n따뜻한 마음이 여기저기 퍼져나가고 있어요! "),
    ]
    
    var userLinks: [String] = ["", "", "", ""]
    var changeLinks: [String] = []
    var filterLinks: [(Int, String)] = []
}

// MARK: - birthday
extension ProfileViewModel {
    func getUserAge() -> Int {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        guard let currentYear = Int(dateFormatter.string(from: currentDate)),
              let birthYearString = user.birthDay.components(separatedBy: "-").first,
              let birthYear = Int(birthYearString)
        else { return 0 }

        return currentYear - birthYear + 1
    }
}

// MARK: - Link
extension ProfileViewModel {
    func getMyPageData(completion: @escaping (Bool) -> Void) {
        guard let token = auth.getAccessToken() else { return }
        useCase.getMyPageData(request: .init(authorization: token)) { data in
            if let data = data {
                self.user = data
                self.filteringLinks()
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func changeArrayFromSnsData() {
        userLinks[0] = user.snsPlatform?.instagram ?? ""
        userLinks[1] = user.snsPlatform?.x ?? ""
        userLinks[2] = user.snsPlatform?.tiktok ?? ""
        userLinks[3] = user.snsPlatform?.youtube ?? ""
    }
    
    func checkChangeLinks(tag: Int, text: String) -> Bool {
        changeLinks[tag] = text
        
        if userLinks == changeLinks {
            return true
        } else {
            return false
        }
    }
    
    func filteringLinks() {
        filterLinks.removeAll()
        changeArrayFromSnsData()
        
        userLinks.enumerated().forEach { (tag, link) in
            if !link.isEmpty {
                filterLinks.append((tag, link))
            }
        }
    }
    
    func saveUserLinks(completion: @escaping () -> Void) {
        // TODO: 서버 저장 로직
        guard let token = auth.getAccessToken() else { return }
        
        var snsLink: SnsLinkData? = nil
        
        if changeLinks.contains(where: { $0 != "" }) {
            snsLink = .init(
                instagram: self.changeLinks[0],
                x: self.changeLinks[1],
                tiktok: self.changeLinks[2],
                youtube: self.changeLinks[3])
        }

        useCase.editMyPage(
            request: .init(
                authorization: token,
                nickName: user.nickName,
                schoolData: .init(
                    schoolName: user.schoolName,
                    schoolLocation: user.location),
                snsPlatform: snsLink,
                mbti: user.mbti,
                introduction: user.introduction,
                questions: user.questions)
        ) { data in
            if let _ = data {
                self.user.snsPlatform = snsLink
                self.filteringLinks()
                completion()
            }
        }
    }
}
