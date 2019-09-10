//
//  PhotoNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

protocol PhotosNavigation {
    func toPhotos()
    func toPhoto(photo: Photo)
}

final class PhotosNavigator: PhotosNavigation {
    
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
        let photoNavigator = PhotoNavigator(self.navigationController)
        let photoViewModel = PhotoViewModel(photoNavigator, photo: photo)
        let photoViewController = PhotoViewController(photoViewModel)
        navigationController.pushViewController(photoViewController, animated: true)
    }
}
