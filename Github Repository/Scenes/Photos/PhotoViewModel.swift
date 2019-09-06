//
//  PhotoViewModel.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

final class PhotoViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let photoUseCase: PhotoUseCase
    
    init(_ photoUseCase: PhotoUseCase) {
        self.photoUseCase = photoUseCase
    }
    
    func transform(input: PhotoViewModel.Input) -> PhotoViewModel.Output {
        return Output()
    }
    
}
