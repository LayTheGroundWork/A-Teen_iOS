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
        // userDefaults
        let tokenStorage: TokenStorage = TokenStorage()
        
        // user
        let allUserFindRepository: AllUserFindRepository = AllUserFindRepositoryImp(apiClientService: apiClientService)
        let categoryUserFindRepository: CategoryUserFindRepository = CategoryUserFindRepositoryImp(apiClientService: apiClientService)
        let userDetailRepository: UserDetailRepository = UserDetailRepositoryImp(apiClientService: apiClientService)
        let userLikeRepository: UserLikeRepository = UserLikeRepositoryImp(apiClientService: apiClientService)
        let userLikeCancelRepository: UserLikeCancelRepository = UserLikeCancelRepositoryImp(apiClientService: apiClientService)
        
        // sign
        let signInRepository: SignInRepository = SignInRepositoryImp(apiClientService: apiClientService)
        let signUpRepository: SignUpRepository = SignUpRepositoryImp(apiClientService: apiClientService)
        let duplicationCheckRepository: DuplictaionCheckRepository = DuplicationCheckRepositoryImp(apiClientService: apiClientService)
        let requestCodeRepository: RequestCodeRepository = RequestCodeRepositoryImp(apiClientService: apiClientService)
        let verificationCodeRepository: VerificationCodeRepository = VerificationCodeRepositoryImp(apiClientService: apiClientService)
        
        // school
        let schoolDataRepository: SchoolDataRepository = SchoolDataRepositoryImp(apiClientService: apiClientService)
        
        // image
        let remoteImageDataRepository: RemoteImageDataRepository = RemoteImageDataRepositoryImp(apiClientService: apiClientService)
        
        // mypage
        let myPageRepository: MyPageRepository = MyPageRepositoryImp(apiClientService: apiClientService)
        let myPageEditRepository: MyPageEditRepository = MyPageEditRepositoryImp(apiClientService: apiClientService)
        
        // MARK: - Service
        let userService: UserService = UserServiceImp(
            allUserFindRepository: allUserFindRepository,
            categoryUserFindRepository: categoryUserFindRepository,
            userDetailRepository: userDetailRepository,
            userLikeRepository: userLikeRepository,
            userLikeCancelRepository: userLikeCancelRepository)
        
        let signService: SignService = SignServiceImp(
            signInRepository: signInRepository,
            signUpRepository: signUpRepository,
            duplicationCheckRepository: duplicationCheckRepository,
            requestCodeRepository: requestCodeRepository,
            verificationCodeRepository: verificationCodeRepository)

        let searchService: SearchSchoolService = SearchSchoolServiceImp(schoolDataRepository: schoolDataRepository)
        
        let imageDataService: ImageDataService = ImageDataServiceImp(remoteImageDataRepository: remoteImageDataRepository)
        
        let myPageService: MyPageService = MyPageServiceImp(
            myPageRepository: myPageRepository,
            myPageEditRepository: myPageEditRepository)
        
        // MARK: - UseCase
        let auth: Auth = Auth(tokenHandler: tokenStorage)
        
        let userUseCase: UserUseCase = UserUseCaseImp(userService: userService)
        
        let signUseCase: SignUseCase = SignUseCaseImp(
            signService: signService, 
            searchService: searchService
        )

        let imageDataUseCase: ImageDataUseCase = ImageDataUseCaseImp(imageDataService: imageDataService)
        
        let searchUseCase: SearchUseCase = SearchUseCaseImp(schoolDataRepository: schoolDataRepository)
        
        let myPageUseCase: MyPageUseCase = MyPageUseCaseImp(myPageService: myPageService)
        
        // MARK: - Register
        AppContainer.register(
            type: Auth.self,
            auth)
        
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
            type: SearchUseCase.self,
            searchUseCase)
        
        AppContainer.register(
            type: MyPageUseCase.self,
            myPageUseCase)
    }
}
