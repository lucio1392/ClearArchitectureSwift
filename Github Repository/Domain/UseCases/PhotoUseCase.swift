//
//  PhotoUseCase.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

public protocol PhotoUseCase {
    func photos() -> Observable<[Photo]>
}
