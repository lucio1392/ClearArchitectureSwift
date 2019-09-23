//
//  PhotoViewModel.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt
import Moya

final class PhotosViewModel: ViewModelType {
    
    struct Input {
        let onToPhoto: Driver<Photo>
    }
    
    struct Output {
        let photos: Driver<[Photo]>
        let error: Driver<String>
    }
    
    private let photoUseCase: PhotoUseCase
    private let photosCoordinator: PhotoComponentCoordinator
    private let disposedBag = DisposeBag()
    
    init(_ photoUseCase: PhotoUseCase, photosCoordinator: PhotoComponentCoordinator) {
        self.photoUseCase = photoUseCase
        self.photosCoordinator = photosCoordinator
    }
    
    func transform(input: Input) -> Output {
        let photosRequest = photoUseCase
            .photos()
            .materialize()
            .share()
        
        let photos = photosRequest
            .elements()
            .asDriver(onErrorJustReturn: [])
        
        let error = photosRequest
            .photoErrors()
            .map { $0.localizedDescription }            
            .asDriver(onErrorJustReturn: "")
        
        input
            .onToPhoto
            .drive()
            .disposed(by: disposedBag)
        
        return Output(photos: photos,
                      error: error)
    }
    
}
