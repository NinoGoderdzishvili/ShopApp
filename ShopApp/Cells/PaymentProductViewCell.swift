//
//  PaymentProductViewCell.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/28/23.
//

import UIKit

class PaymentProductViewCell: UITableViewCell {

    @IBOutlet weak var prdouctImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productTotalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
