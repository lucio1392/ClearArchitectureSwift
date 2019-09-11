//
//  OpenAuthenticationViewController.swift
//  Github Repository
//
//  Created by Macbook on 9/11/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxWebKit

class OpenAuthenticationViewController: UIViewController {
    
    @IBOutlet weak var authenWebkit: WKWebView!
    
    private let viewModel: OpenAuthenticationViewModel
    private let disposeBag = DisposeBag()
    
    init(_ viewModel: OpenAuthenticationViewModel) {
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
        let input = OpenAuthenticationViewModel
            .Input(authenUrl: authenWebkit
                .rx.didFinishNavigation
                .flatMapLatest { _ in return self.authenWebkit.rx.url.map {$0!}
            })
        
        let output = viewModel.transform(input: input)
        
        output
            .oauthRedirectURLRequest
            .subscribe(onNext: { [weak self] urlRequest in
                guard let `self` = self else { return }
                self.authenWebkit.load(urlRequest)
        })
            .disposed(by: disposeBag)
    }

}
