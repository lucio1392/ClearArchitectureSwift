//
//  HostAppViewController.swift
//  Github Repository
//
//  Created by Macbook on 9/23/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

class HostAppViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func onOpenSDK(_ sender: UIButton) {        
        Application.default.openLogin()
    }
}
