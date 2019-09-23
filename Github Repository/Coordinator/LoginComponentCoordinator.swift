//
//  LoginComponentCoordinator.swift
//  Github Repository
//
//  Created by Lucio on 9/22/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginComponentDelegate: class {
    func didLogin()
}

class LoginComponentCoordinator: BaseComponentCoordinator {

    weak var delegate: LoginComponentDelegate?
    
}
