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
        let auth: Auth = Auth()
        let apiClientService: ApiClientService = ApiClientServiceImp()
        
        // MARK: - Repository
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
        
        // MARK: - Service
        let signService: SignService = SignServiceImp(
            signInRepository: signInRepository,
            signUpRepository: signUpRepository,
            duplicationCheckRepository: duplicationCheckRepository,
            requestCodeRepository: requestCodeRepository,
            verificationCodeRepository: verificationCodeRepository)

        let searchService: SearchSchoolService = SearchSchoolServiceImp(schoolDataRepository: schoolDataRepository)
        
        let imageDataService: ImageDataService = ImageDataServiceImp(remoteImageDataRepository: remoteImageDataRepository)
        
        // MARK: - UseCase
        let signUseCase: SignUseCase = SignUseCaseImp(
            signService: signService, 
            searchService: searchService
        )

        let imageDataUseCase: ImageDataUseCase = ImageDataUseCaseImp(imageDataService: imageDataService)
        
        let searchUseCase: SearchUseCase = SearchUseCaseImp(schoolDataRepository: schoolDataRepository)
        
        // MARK: - Register
        AppContainer.register(
            type: Auth.self,
            auth)
        
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
    }
}
