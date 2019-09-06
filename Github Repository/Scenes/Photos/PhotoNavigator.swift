//
//  PhotoNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

final class PhotoNavigator {
    
    private let useCaseProvider: UseCasesProvider
    private let navigationController: UINavigationController
    
    init(_ useCaseProvider: UseCasesProvider,
         navigationController: UINavigationController) {
        self.useCaseProvider = useCaseProvider
        self.navigationController = navigationController
    }
    
}
