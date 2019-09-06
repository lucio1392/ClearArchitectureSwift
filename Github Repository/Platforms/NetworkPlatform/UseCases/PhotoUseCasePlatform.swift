//
//  PhotoUseCase.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift
import Moya

final class PhotoUseCasePlatform: PhotoUseCase {
    
    private let network = Network<Photo, PhotoTarget>()
    
    func photos() -> Observable<[Photo]> {
        return network.getItems(.photos)
    }
    
}
