//
//  LoginViewController.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
