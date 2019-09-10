//
//  PhotoViewController.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: PhotoViewModel
    
    init(_ viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: PhotoViewModel.Input())
        
        output
            .photo
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
               self.photoImageView.kf.setImage(with: $0)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }


}
