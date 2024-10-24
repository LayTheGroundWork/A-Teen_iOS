//
//  SignUpViewModel.swift
//  LoginFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Combine
import Domain
import Photos
import UIKit

public final class SignUpViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(SignUseCase.self)
    public var signUseCase: SignUseCase
    
    @Injected(SearchUseCase.self)
    public var searchUseCase: SearchUseCase
    
    var state = PassthroughSubject<StateController, Never>()
    
    // phoneNumber
    public var phoneNumber: String = .empty
    public var userId: String = .empty
    public var userName: String = .empty
    
    //UserBirth
    public var year: String = .empty
    public var month: String = .empty
    public var day: String = .empty
    
    //SearchSchool
    public var schoolData: SchoolData = SchoolData(schoolName: .empty, schoolLocation: .empty)
    
    public var searchSchoolText: String = .empty
    public var filteredSchools: [SchoolData] = []
    public var selectIndexPath: IndexPath?
    
    //Category
    public var category: CategoryType = CategoryType.none
    
    let categoryExplain: [CategoryType] = [
        .beauty,
        .exercise,
        .study,
        .art,
        .game,
        .etc
    ]
    
    //SelectPhoto
    var selectPhotoList: [AlbumType] = [.init(image: nil), .init(image: nil)]
    
    private let authService = MyPhotoAuthService()
    
    // MARK: - Helpers
    public func searchSchoolData(completion: @escaping () -> Void) {
        state.send(.loading)
        signUseCase.searchSchool(request: SchoolDataRequest(schoolName: searchSchoolText)) { filteredSchools in
            self.filteredSchools = filteredSchools
            self.state.send(.success)
            completion()
        }
    }
    
    func duplicationCheck(completion: @escaping (Bool) -> Void) {
        signUseCase.duplicationCheck(request: .init(uniqueId: userId)) { check in
            completion(check)
        }
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        signUseCase.signUp(
            request: .init(
                phoneNumber: phoneNumber,
                userId: userId,
                userName: userName,
                birthDate: "\(year)-\(month)-\(day)",
                schoolData: schoolData,
                category: category.rawValue,
                tournamentJoin: true
            )) { result in
                switch result {
                case .success(let tokenData):
                    self.auth.setAccessToken(tokenData.authToken)
                    self.auth.setRefreshToken(tokenData.refreshToken)
                    self.auth.logIn()
                    completion(self.auth.isSessionActive)
                case .failure(let error):
                    print("회원가입 실패:", error.localizedDescription)
                    completion(false)
                }
            }
    }
}

// MARK: - UserName
extension SignUpViewModel {
    // 영어 & 한글 & 숫자
    public func checkRegex(_ text: String) -> Bool {
        let characterRegex = ATeenRegex.characterAndNumber
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: characterRegex)
        let result = regex.firstMatch(in: text, options: [], range: range) != nil
        return result
    }
    
    /// 불완전한 한글 단어 확인
    /// ex. ㅅㅏ, ㄹㅏㅇ, ㅐㅎ
    public func isIncompleteKoreanWord(_ text: String) -> Bool {
        let completeKoreanRegex = ATeenRegex.completeKorean
        let incompleteKoreanRegex = ATeenRegex.incompleteKorean
        
        let completeRegex = try! NSRegularExpression(pattern: completeKoreanRegex)
        let incompleteRegex = try! NSRegularExpression(pattern: incompleteKoreanRegex)
        
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let isCompleteKorean = completeRegex.firstMatch(in: text, options: [], range: range) != nil
        let hasIncompleteKorean = incompleteRegex.firstMatch(in: text, options: [], range: range) != nil
        return !isCompleteKorean && hasIncompleteKorean
    }
}

// MARK: - UserBirth
extension SignUpViewModel {
    public func changeMonthState() -> Int {
        if month == "2" && (day == "29" || day == "30" || day == "31") {
            if leapYear() {
                day = "29"
            } else {
                day = "28"
            }
        } else if month == "4" && self.day == "31" {
            day = "30"
        } else if month == "6" && self.day == "31" {
            day = "30"
        } else if month == "9" && self.day == "31" {
            day = "30"
        } else if month == "11" && self.day == "31" {
            day = "30"
        }
        return (Int(day) ?? 1) - 1
    }
    
    public func leapYear() -> Bool {
        let yearInt = Int(year) ?? 0
        
        if yearInt % 400 == 0 {
            return true
        } else if yearInt % 100 != 0 && yearInt % 4 == 0{
            return true
        } else {
            return false
        }
    }
}

// MARK: - SelectCategory
extension SignUpViewModel {
    public func changeCategory(index: Int, completion: () -> Void) {
        category = categoryExplain[index]
        print(category)
        completion()
    }
}

// MARK: - SelectPhoto
extension SignUpViewModel {
    public func extractImageFromVideo(asset: AVAsset, completion: @escaping(UIImage) -> Void) {
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true // 비디오의 회전을 반영
        
        do {
            // 요청된 시간에서 이미지를 생성
            let cgImage = try imageGenerator.copyCGImage(
                at: CMTime(seconds: 0.0, preferredTimescale: 600),
                actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            completion(image)
        } catch {
            print("Error extracting image: \(error.localizedDescription)")
        }
    }
    
    func addAlbumItem(index: Int, albumType: AlbumType, completion: () -> Void) {
        if selectPhotoList.indices.contains(index) {
            selectPhotoList[index] = albumType
        } else {
            selectPhotoList.append(albumType)
        }
        completion()
    }
}
