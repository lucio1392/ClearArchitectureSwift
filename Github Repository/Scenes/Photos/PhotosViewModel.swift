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
    private let photosNavigator: PhotosNavigation
    private let disposedBag = DisposeBag()
    
    init(_ photoUseCase: PhotoUseCase, photoNavigator: PhotosNavigation) {
        self.photoUseCase = photoUseCase
        self.photosNavigator = photoNavigator
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
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.photosNavigator.toPhoto(photo: $0)
        })
            .disposed(by: disposedBag)
        
        return Output(photos: photos,
                      error: error)
    }
    
}
