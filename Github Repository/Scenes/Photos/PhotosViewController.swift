//
//  PhotosViewController.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: PhotosViewModel
    
    init(_ viewModel: PhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCell")
        guard let photoLayout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        photoLayout.itemSize = CGSize(width: 200, height: 200)
        photoLayout.minimumInteritemSpacing = 10.0
        photoLayout.minimumLineSpacing = 10.0
    }
    
    private func bindViewModel() {
        let onToPhoto = photosCollectionView.rx.modelSelected(Photo.self).asDriver()
        let input = PhotosViewModel.Input(onToPhoto: onToPhoto)
        let output = viewModel.transform(input: input)
        
        output
            .photos
            .drive(photosCollectionView.rx.items(cellIdentifier: "PhotosCell", cellType: PhotoCollectionViewCell.self)) { cl, model, cell in
            cell.bind(model)
        }
            .disposed(by: disposeBag)
        
        
        output
            .error
            .drive(onNext: {
                print("Error: \($0)")
        })
            .disposed(by: disposeBag)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindViewModel()
    }
    
}
