//
//  PhotoCollectionViewCell.swift
//  Github Repository
//
//  Created by Macbook on 9/9/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 6.0
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.backgroundColor = .red
        
    }
    
    func bind(_ photo: Photo) {
        photoImageView.kf.setImage(with: URL(string: photo.photoSource.full!)!)        
    }

}
