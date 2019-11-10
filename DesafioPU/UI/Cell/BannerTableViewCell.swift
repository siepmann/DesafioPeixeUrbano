//
//  BannerTableViewCell.swift
//  teste
//
//  Created by Guilherme Siepmann on 07/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    private var collectionView: UICollectionView!
    private var bannerDataSource: [Banner] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        
        collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reusableIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with banners: [Banner]) {
        self.bannerDataSource = banners
        self.contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerDataSource = []
    }
}

extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reusableIdentifier, for: indexPath)
        (cell as! BannerCollectionViewCell).setupCell(with: bannerDataSource[indexPath.row])
        return cell
    }
}
