//
//  TableViewCellDelegate.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/26/23.
//

import Foundation

//protocol TableViewCellDelegate: AnyObject {
//    func getData(data: Any)
//}

protocol CustomTableViewCellDelegate: AnyObject {
    func updateLabel(in cell: ProductViewCell)
}
