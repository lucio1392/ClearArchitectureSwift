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

final class PhotosViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let photos: Driver<[Photo]>
    }
    
    private let photoUseCase: PhotoUseCase
    private let photosNavigator: PhotoNavigation
    
    init(_ photoUseCase: PhotoUseCase, photoNavigator: PhotoNavigation) {
        self.photoUseCase = photoUseCase
        self.photosNavigator = photoNavigator
    }
    
    func transform(input: Input) -> Output {
        let photos = photoUseCase.photos().asDriver(onErrorJustReturn: [])
        
        return Output(photos: photos)
    }
    
}
