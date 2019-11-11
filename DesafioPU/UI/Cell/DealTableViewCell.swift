//
//  DealTableViewCell.swift
//  teste
//
//  Created by Guilherme Siepmann on 07/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class DealTableViewCell: UITableViewCell {
    private var footerView: DealFooterView!
    private var currentDeal: Deal!
    
    private let view: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dealImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let partnerNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
//    private let favIconViewHolder: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
//        view.layer.cornerRadius = 20
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "FavIconOff"), for: .normal)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func setupCell(with deal: Deal) {
        self.selectionStyle = .none
        self.currentDeal = deal
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        
        self.footerView = DealFooterView(with: deal.shortTitle, andPrice: deal.minSalePrice)
        self.footerView.translatesAutoresizingMaskIntoConstraints = false
        
        if let model = deal.images.first, let imagURLString = model.image, let imageURL = URL(string: imagURLString) {
            self.dealImageView.load(url: imageURL, placeholder: nil)
        }
        
        if deal.isFavorited() {
            favoriteButton.setImage(#imageLiteral(resourceName: "FavIconOn"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "FavIconOff"), for: .normal)
        }
        
        partnerNameLabel.text = deal.partner?.name ?? ""
        
        self.setHierarchy()
        self.setConstraints()
    }
    
    @objc private func favoriteTapped() {
        if currentDeal.isFavorited() {
            FavoriteManager.shared.removeFromFavorite(deal: currentDeal)
            favoriteButton.setImage(#imageLiteral(resourceName: "FavIconOff"), for: .normal)
        } else {
            FavoriteManager.shared.addToFavorite(deal: currentDeal)
            favoriteButton.setImage(#imageLiteral(resourceName: "FavIconOn"), for: .normal)
        }
    }
    
    private func setHierarchy() {
        self.contentView.addSubview(self.dealImageView)
        self.dealImageView.addSubview(self.view)
        self.dealImageView.addSubview(self.partnerNameLabel)
//        self.dealImageView.addSubview(self.favIconViewHolder)
        self.dealImageView.addSubview(self.favoriteButton)
        self.contentView.addSubview(self.footerView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.dealImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.dealImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.dealImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.dealImageView.bottomAnchor.constraint(equalTo: self.footerView.topAnchor),
            
            self.view.topAnchor.constraint(equalTo: self.dealImageView.topAnchor),
            self.view.rightAnchor.constraint(equalTo: self.dealImageView.rightAnchor),
            self.view.leftAnchor.constraint(equalTo: self.dealImageView.leftAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.dealImageView.bottomAnchor),
            
            self.partnerNameLabel.leftAnchor.constraint(equalTo: self.dealImageView.leftAnchor, constant: 16),
            self.partnerNameLabel.bottomAnchor.constraint(equalTo: self.dealImageView.bottomAnchor, constant: -16),
            self.partnerNameLabel.rightAnchor.constraint(equalTo: self.favoriteButton.leftAnchor, constant: -8),
            
//            self.favIconViewHolder.bottomAnchor.constraint(equalTo: self.dealImageView.bottomAnchor, constant: -16),
//            self.favIconViewHolder.rightAnchor.constraint(equalTo: self.dealImageView.rightAnchor, constant: -16),
//            self.favIconViewHolder.widthAnchor.constraint(equalToConstant: 40),
//            self.favIconViewHolder.heightAnchor.constraint(equalToConstant: 40),
            
            self.favoriteButton.bottomAnchor.constraint(equalTo: self.dealImageView.bottomAnchor, constant: -16),
            self.favoriteButton.rightAnchor.constraint(equalTo: self.dealImageView.rightAnchor, constant: -16),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.footerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.footerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.footerView.heightAnchor.constraint(equalToConstant: 70),
            self.footerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
}
