//
//  Product.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/23/23.
//

import Foundation
import UIKit

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Decimal
    let discountPercentage: Decimal
    let rating: Decimal
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}
