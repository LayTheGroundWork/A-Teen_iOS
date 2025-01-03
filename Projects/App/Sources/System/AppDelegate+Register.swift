//
//  AppDelegate+Register.swift
//  App
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Data
import Domain
import NetworkService
import Foundation

extension AppDelegate {
    func registerDependencies() {
        let apiClientService: ApiClientService = ApiClientServiceImp()
        
        // MARK: - Repository
        // user
        let categoryTodayTeenFindRepository: CategoryTodayTeenFindRepository = CategoryTodayTeenFindRepositoryImp(apiClientService: apiClientService)
        let categoryUserFindRepository: CategoryUserFindRepository = CategoryUserFindRepositoryImp(apiClientService: apiClientService)
        let userDetailRepository: UserDetailRepository = UserDetailRepositoryImp(apiClientService: apiClientService)
        let userLikeRepository: UserLikeRepository = UserLikeRepositoryImp(apiClientService: apiClientService)
        let userLikeCancelRepository: UserLikeCancelRepository = UserLikeCancelRepositoryImp(apiClientService: apiClientService)
        let searchUserRepository: SearchUserRepository = SearchUserRepositoryImp(apiClientService: apiClientService)
        
        // sign
        let signInRepository: SignInRepository = SignInRepositoryImp(apiClientService: apiClientService)
        let signUpRepository: SignUpRepository = SignUpRepositoryImp(apiClientService: apiClientService)
        let duplicationCheckRepository: DuplictaionCheckRepository = DuplicationCheckRepositoryImp(apiClientService: apiClientService)
        let requestCodeRepository: RequestCodeRepository = RequestCodeRepositoryImp(apiClientService: apiClientService)
        let verificationCodeRepository: VerificationCodeRepository = VerificationCodeRepositoryImp(apiClientService: apiClientService)
        let reissueRepository: ReissueRepository = ReissueRepositoryImp(apiClientService: apiClientService)
        let signOutRepository: SignOutRepository = SignOutRepositoryImp(apiClientService: apiClientService)
        let deleteAccountRepository: DeleteAccountRepository = DeleteAccountRepositoryImp(apiClientService: apiClientService)
        
        // school
        let schoolDataRepository: SchoolDataRepository = SchoolDataRepositoryImp(apiClientService: apiClientService)
        
        // image
        let remoteImageDataRepository: RemoteImageDataRepository = RemoteImageDataRepositoryImp(apiClientService: apiClientService)
        
        // tournament
        let tournamentSearchRepository: TournamentSearchRepository = TournamentSearchRepositoryImp(apiClientService: apiClientService)
        let tournamentResultRepository: TournamentResultRepository = TournamentResultRepositoryImp(apiClientService: apiClientService)
        let thisWeekParticipantsRepository: ThisWeekParticipantsRepository = ThisWeekParticipantsRepositoryImp(apiClientService: apiClientService)
        let tournamentVoteRepository: TournamentVoteRepository = TournamentVoteRepositoryImp(apiClientService: apiClientService)
        
        // mypage
        let myPageRepository: MyPageRepository = MyPageRepositoryImp(apiClientService: apiClientService)
        let myPageEditRepository: MyPageEditRepository = MyPageEditRepositoryImp(apiClientService: apiClientService)
        
        // MARK: - DataStore
        // userDefaults
        let tokenStorage: TokenStorage = TokenStorage()
        // Auth
        let auth: Auth = Auth(tokenHandler: tokenStorage)
        
        // MARK: - Service
        let userService: UserService = UserServiceImp(
            auth: auth, 
            categoryTodayTeenFindRepository: categoryTodayTeenFindRepository,
            categoryUserFindRepository: categoryUserFindRepository,
            userDetailRepository: userDetailRepository,
            userLikeRepository: userLikeRepository,
            userLikeCancelRepository: userLikeCancelRepository,
            searchUserRepository: searchUserRepository,
            reissueRepository: reissueRepository)
        
        let signService: SignService = SignServiceImp(
            auth: auth,
            signInRepository: signInRepository,
            signUpRepository: signUpRepository,
            duplicationCheckRepository: duplicationCheckRepository,
            requestCodeRepository: requestCodeRepository,
            verificationCodeRepository: verificationCodeRepository)

        let searchService: SearchSchoolService = SearchSchoolServiceImp(schoolDataRepository: schoolDataRepository)
        
        let imageDataService: ImageDataService = ImageDataServiceImp(remoteImageDataRepository: remoteImageDataRepository)
        
        let tournamentService: TournamentService = TournamentServiceImp(
            auth: auth,
            tournamentSearchRepository: tournamentSearchRepository,
            tournamentResultRepository: tournamentResultRepository, 
            thisWeekParticipantsRepository: thisWeekParticipantsRepository,
            tournamentVoteRepository: tournamentVoteRepository,
            reissueRepository: reissueRepository)
        
        let myPageService: MyPageService = MyPageServiceImp(
            auth: auth,
            myPageRepository: myPageRepository,
            myPageEditRepository: myPageEditRepository,
            reissueRepository: reissueRepository)
        
        let settingsService: SettingsService = SettingsServiceImp(
            auth: auth,
            signOutRepository: signOutRepository,
            deleteAccountRepository: deleteAccountRepository)
        
        // MARK: - UseCase
        let userUseCase: UserUseCase = UserUseCaseImp(userService: userService)
        
        let signUseCase: SignUseCase = SignUseCaseImp(
            signService: signService, 
            searchService: searchService
        )

        let imageDataUseCase: ImageDataUseCase = ImageDataUseCaseImp(imageDataService: imageDataService)
        
        let tournamentUseCase: TournamentUseCase = TournamentUseCaseImp(tournamentService: tournamentService)
        
        let myPageUseCase: MyPageUseCase = MyPageUseCaseImp(myPageService: myPageService, searchService: searchService)
        
        let settingsUseCase: SettingsUseCase = SettingsUseCaseImp(settingsService: settingsService)
        
        // MARK: - Register
        AppContainer.register(
            type: UserUseCase.self,
            userUseCase)
        
        AppContainer.register(
            type: SignUseCase.self,
            signUseCase)
        
        AppContainer.register(
            type: ImageDataUseCase.self,
            imageDataUseCase
        )
        
        AppContainer.register(
            type: TournamentUseCase.self,
            tournamentUseCase)
        
        AppContainer.register(
            type: MyPageUseCase.self,
            myPageUseCase)
        
        AppContainer.register(
            type: SettingsUseCase.self,
            settingsUseCase)
    }
}
