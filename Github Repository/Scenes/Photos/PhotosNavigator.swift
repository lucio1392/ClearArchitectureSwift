//
//  PhotoNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoNavigation {
    func toPhotos()
    func toPhoto(photo: Photo)
}

final class PhotoNavigator: PhotoNavigation {
    
    private let useCaseProvider: UseCasesProvider
    private let navigationController: UINavigationController
    
    init(_ useCaseProvider: UseCasesProvider,
         navigationController: UINavigationController) {
        self.useCaseProvider = useCaseProvider
        self.navigationController = navigationController
    }
    
    func toPhotos() {
        let photosViewModel = PhotosViewModel(useCaseProvider.makePhotoUseCaseProvider(), photoNavigator: self)
        let photosViewController = PhotosViewController(photosViewModel)
        photosViewController.title = "Photos"
        navigationController.pushViewController(photosViewController, animated: true)
    }
    
    func toPhoto(photo: Photo) {
        
    }
}
