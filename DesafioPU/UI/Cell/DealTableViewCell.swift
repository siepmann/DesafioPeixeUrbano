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
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ""), for: .normal)
        button.setTitle("", for: .normal)
        //        button.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        self.footerView = DealFooterView(with: deal.shortTitle, andPrice: deal.minSalePrice)
        self.footerView.translatesAutoresizingMaskIntoConstraints = false
        
        if let model = deal.images?.first, let imagURLString = model.image, let imageURL = URL(string: imagURLString) {
            self.dealImageView.load(url: imageURL, placeholder: nil)
        }
        
        partnerNameLabel.text = deal.partner?.name ?? ""
        
        self.setHierarchy()
        self.setConstraints()
    }
    
    private func setHierarchy() {
        self.contentView.addSubview(self.dealImageView)
        self.dealImageView.addSubview(self.view)
        self.dealImageView.addSubview(self.partnerNameLabel)
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
            
            self.footerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.footerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.footerView.heightAnchor.constraint(equalToConstant: 70),
            self.footerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
}
