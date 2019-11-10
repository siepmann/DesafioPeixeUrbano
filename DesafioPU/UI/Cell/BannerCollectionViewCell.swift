//
//  BannerCollectionViewCell.swift
//  teste
//
//  Created by Guilherme Siepmann on 07/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.contentView.addSubview(bannerImageView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            bannerImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            bannerImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            bannerImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with banner: Banner) {
        if let imageString = banner.mobile?.mobileImage, let url = URL(string: imageString) {
            bannerImageView.load(url: url, placeholder: nil)
        }
    }
}
