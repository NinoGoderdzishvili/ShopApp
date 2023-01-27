//
//  ProductViewCell.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/25/23.
//

import UIKit

class ProductViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productStockLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    
    private var quantity: Int = 0
    private var sumQuantity: Int = 0
    
    weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        productImage.layer.borderWidth = 0.5
        productImage.layer.masksToBounds = false
        productImage.layer.borderColor = UIColor.lightGray.cgColor
        productImage.layer.cornerRadius = 15
        productImage.clipsToBounds = true
        
        self.makeTextBold(label: productNameLbl)
        self.makeTextBold(label: productStockLbl)
        self.makeTextBold(label: productPriceLbl)
        self.makeTextBold(label: productQuantityLbl)
        
        self.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func makeTextBold(label: UILabel) {
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        
        if self.quantity > 0 {
            self.sumQuantity -= self.quantity
            self.quantity -= 1
            updateItemQuantity(isIncreasing: false)
        }
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
        self.quantity += 1
        self.sumQuantity += self.quantity
        updateItemQuantity(isIncreasing: true)
    }
    
    func updateItemQuantity(isIncreasing: Bool) {
        self.quantity = isIncreasing ? self.quantity + 1 : self.quantity - 1
        productQuantityLbl.text = "\(self.quantity)"
        delegate?.getData(data: productQuantityLbl.text)
    }
    
    func setImage(image: UIImage){
        self.productImage.image = image
    }
    
}
