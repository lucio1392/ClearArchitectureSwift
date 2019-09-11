//
//  LoginViewController.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
    }
    
    private func bindViewModel() {
        
        let input = LoginViewModel.Input(onLogin: loginButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output
            .authenResult
            .subscribe(onNext: {
            print("Accesstoken: \($0)")
        })
            .disposed(by: disposeBag)
        
    }

}
