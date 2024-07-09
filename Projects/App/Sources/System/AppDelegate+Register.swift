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
        let signRepository: SignRepository = SignRepositoryImp(apiClientService: apiClientService)
        let verificateService: VerificateService = VerificateServiceImp(apiClientService: apiClientService)
        
        let signUseCase: SignUseCase = SignUseCaseImp(
            repository: signRepository,
            service: verificateService)
        
        let remoteDataService: RemoteImageDataService = RemoteImageDataServiceImp(apiClientService: apiClientService)
        let localDataCache: LocalDataImageService = LocalDataImageServiceImp()
        
        let imageDataRepository: ImageDataRepository = ImageDataRepositoryImp(
            remoteDataService: remoteDataService,
            localDataCache: localDataCache)
        let imageDataUseCase: ImageDataUseCase = ImageDataUseCaseImp(imageDataRepository: imageDataRepository)
        
        
        let schoolDataRepository: SchoolDataRepository = SchoolDataRepositoryImp(apiClientService: apiClientService)
        let searchUseCase: SearchUseCase = SearchUseCaseImp(schoolDataRepository: schoolDataRepository)
        
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
