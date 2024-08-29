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
        
        // Sign
        let duplicationCheckRepository: DuplictaionCheckRepository = DuplicationCheckRepositoryImp(apiClientService: apiClientService)
        let signRepository: SignRepository = SignRepositoryImp(apiClientService: apiClientService)
        let verificateRepository: VerificateRepository = VerificateRepositoryImp(apiClientService: apiClientService)
        let signService: SignService = SignServiceImp(
            duplicationCheckRepository: duplicationCheckRepository,
            signRepository: signRepository,
            verificateRepository: verificateRepository)
       
        // search
        let schoolDataRepository: SchoolDataRepository = SchoolDataRepositoryImp(apiClientService: apiClientService)
        let searchSchoolService: SearchSchoolService = SearchSchoolServiceImp(schoolDataRepository: schoolDataRepository)
        
        // Image
        let remoteDataService: RemoteImageDataService = RemoteImageDataServiceImp(apiClientService: apiClientService)
        let localDataCache: LocalDataImageService = LocalDataImageServiceImp()
        let imageDataRepository: ImageDataRepository = ImageDataRepositoryImp(
            remoteDataService: remoteDataService,
            localDataCache: localDataCache)
        
        // UseCase
        let signUseCase: SignUseCase = SignUseCaseImp(signService: signService, searchService: searchSchoolService)
        let imageDataUseCase: ImageDataUseCase = ImageDataUseCaseImp(imageDataRepository: imageDataRepository)
        
        // MARK: - Register
        AppContainer.register(
            type: SignUseCase.self,
            signUseCase)
        
        AppContainer.register(
            type: ImageDataUseCase.self,
            imageDataUseCase
        )
    
    }
}
