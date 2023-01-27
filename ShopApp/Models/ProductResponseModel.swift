//
//  ProductResponseModel.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/23/23.
//

import Foundation

struct ProductResponseModel: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
