//
//  DealView.swift
//  DesafioPU
//
//  Created by Guilherme Siepmann on 11/8/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class DealImageView: UIImageView {
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.tintColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
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

    private let partnerName: String
    private let isFavorited: Bool
    
    init(image: UIImage?, partnerName: String, markedAsFavorite: Bool) {
        self.partnerName = partnerName
        self.isFavorited = markedAsFavorite
        super.init(image: image)
        
        self.setHierarchy()
        self.setConstraints()
        self.setValues()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setValues() {
        self.titleLabel.text = self.partnerName
    }
    
    private func setHierarchy() {
        self.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
    }
}
