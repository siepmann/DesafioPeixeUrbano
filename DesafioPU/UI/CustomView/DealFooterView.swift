//
//  DealFooterView.swift
//  teste
//
//  Created by Guilherme Siepmann on 07/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class DealFooterView: UIView {
    private var title: String
    private var price: Double
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(with title: String, andPrice price: Double) {
        self.title = title
        self.price = price
        super.init(frame: .zero)
        
        self.setTitle()
        self.formatPrice()
        self.setHierarchy()
        self.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        self.titleLabel.text = self.title
    }
    
    private func formatPrice() {
        let attributedString = NSMutableAttributedString(string: "A partir de ",
                                                         attributes: [
                                                            NSAttributedString.Key.foregroundColor : UIColor.gray,
                                                            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        let attributedCurrency = NSMutableAttributedString(string: "R$ ",
                                                           attributes: [
                                                            NSAttributedString.Key.foregroundColor : UIColor.orange,
                                                            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        
        let attributedPrice = NSMutableAttributedString(string: String(format: "%.2f", self.price),
                                                        attributes: [
                                                            NSAttributedString.Key.foregroundColor : UIColor.orange,
                                                            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedString.append(attributedCurrency)
        attributedString.append(attributedPrice)
        
        priceLabel.attributedText = attributedString
    }
    
    private func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            titleLabel.rightAnchor.constraint(equalTo: self.priceLabel.leftAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            priceLabel.widthAnchor.constraint(equalToConstant: 80)
            ])
    }
}
