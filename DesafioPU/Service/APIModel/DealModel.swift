//
//  BaseModel.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

// MARK: - DealModel
struct DealModel: Codable {
    let code: Int?
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let hasMore: Bool?
    let banners: [Banner]?
//    let categories: [Category]?
    let deals: [Deal]?
}

// MARK: - Banner
struct Banner: Codable {
    let name, title, label: String?
    let priority: Int?
    let startDate, endDate: String?
    let mobile: Mobile?
    let isIos, isAndroid: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name, title, label, priority
        case startDate = "start_date"
        case endDate = "end_date"
        case mobile
        case isIos = "is_ios"
        case isAndroid = "is_android"
    }
}

// MARK: - Mobile
struct Mobile: Codable {
    let pages: [String]?
    let mobileImage: String?
    let type: Int?
    let link, tagMarketing, collections, category: String?
    let subcategories, regions, attributes: String?
    let active, isActivation: Bool?
    
    enum CodingKeys: String, CodingKey {
        case pages
        case mobileImage = "mobile_image"
        case type, link
        case tagMarketing = "tag_marketing"
        case collections, category, subcategories, regions, attributes, active
        case isActivation = "is_activation"
    }
}

// MARK: - Deal
struct Deal: Codable {
    let dealID: String?
    let title, shortTitle: String
    let images: [Image]?
    let fullPrice, salePrice: Double
    let minSalePrice: Double
    let dealImage: String?
    let dealOriginalImage: String?
    let partner: Partner?
    
    enum CodingKeys: String, CodingKey {
        case dealID = "deal_id"
        case title
        case shortTitle = "short_title"
        case images
        case fullPrice = "full_price"
        case salePrice = "sale_price"
        case minSalePrice = "min_sale_price"
        case dealImage, dealOriginalImage
        case partner
    }
}

// MARK: - Image
struct Image: Codable {
    let image, thumb: String?
    let original: String?
}

struct Partner: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
