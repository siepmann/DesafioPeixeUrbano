//
//  DealTableViewCell.swift
//  teste
//
//  Created by Guilherme Siepmann on 07/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class DealTableViewCell: UITableViewCell {
    private var footerView: FooterView!
    
    private let dealImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageViewFooterView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dealTitleLable: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
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
        self.footerView = FooterView(with: deal.title, andPrice: deal.minSalePrice)
        self.footerView.translatesAutoresizingMaskIntoConstraints = false
        self.setHierarchy()
        self.setConstraints()
    }
    
    private func setHierarchy() {
        self.contentView.addSubview(self.footerView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.footerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.footerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.footerView.heightAnchor.constraint(equalToConstant: 70),
            self.footerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
}
