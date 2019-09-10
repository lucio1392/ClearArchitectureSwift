//
//  PhotoNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoNavigation {
    func toPhotos()
}

final class PhotoNavigator: PhotoNavigation {
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toPhotos() {
        navigationController.popViewController(animated: true)
    }
}
