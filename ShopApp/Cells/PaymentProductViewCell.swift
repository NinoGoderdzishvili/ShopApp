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
        
        makeTextBold(label: productTitle)
        makeTextBold(label: productQuantity)
        makeTextBold(label: productTotalPrice)
        
        setupProductImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupProductImage(){
        prdouctImg.layer.borderWidth = 0.5
        prdouctImg.layer.masksToBounds = false
        prdouctImg.layer.borderColor = UIColor.lightGray.cgColor
        prdouctImg.layer.cornerRadius = 15
        prdouctImg.clipsToBounds = true
    }
    
    func makeTextBold(label: UILabel) {
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
    }
}
