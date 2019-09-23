//
//  PhotosComponentCoordinator.swift
//  Github Repository
//
//  Created by Lucio on 9/22/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

enum PhotosScene: Scene {
    
    case photos(PhotosViewModel)
    
    var viewController: UIViewController {
        switch self {
        case .photos(let viewModel):
            let photosViewController = PhotosViewController(viewModel)
            return photosViewController
        }
        
    }
}

class PhotoComponentCoordinator: BaseComponentCoordinator {
    
    
    
}
