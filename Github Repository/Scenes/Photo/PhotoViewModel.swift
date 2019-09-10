//
//  PhotoViewModel.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Kingfisher

final class PhotoViewModel: ViewModelType {

    struct Input {
        
    }
    
    struct Output {
        let photo: Driver<URL>
    }
    
    private let navigator: PhotoNavigation
    private let photo: Photo
    
    init(_ navigator: PhotoNavigation, photo: Photo) {
        self.navigator = navigator
        self.photo = photo
    }
    
    func transform(input: Input) -> Output {
        
        let photoURLDrive = Driver.just(URL.init(string: self.photo.photoSource.full!)!)
        
        return Output(photo: photoURLDrive)
    }
}
