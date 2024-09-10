//
//  ProfileViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public class ProfileViewModel {
    var userName: String = "김 에스더"
    var userImage: UIImage = DesignSystemAsset.blackGlass.image
    var userSchoolName: String = "서울 중학교"
    var userAge: Int = 17
    var userMBTI: String = "INFJ"
    var userIntroduce: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    var userLinks: [String] = ["", "", "", ""]
    var changeLinks: [String] = []
    var filterLinks: [(Int, String)] = []
    
    var questionList: [Question] = [
        .init(
            title: "Lorem ipsum dolor",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """
        ),
        .init(
            title: "Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet?",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """
        ),
        .init(
            title: "Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet?",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """
        ),
    ]
}

// MARK: - Link
extension ProfileViewModel {
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
        
        userLinks.enumerated().forEach { (tag, link) in
            if !link.isEmpty {
                filterLinks.append((tag, link))
            }
        }
    }
    
    func saveUserLinks() {
        // TODO: 서버 저장 로직
        userLinks = changeLinks
        
        filteringLinks()
    }
}
