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
        
        collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        
//        collectionView.registerCollectionViewCell(BannerCollectionViewCell.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with banners: [Banner]) {
        self.bannerDataSource = banners
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
