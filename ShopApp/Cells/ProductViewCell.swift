//
//  ProductViewCell.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/25/23.
//

import UIKit

protocol ProductViewCellDelegate: AnyObject {
    func minusBtnTapped(with productId: Int,
                        with productImage: UIImage,
                        with productName: String,
                        with productQuantity: String,
                        with productPrice: String)
    
    func plusBtnTapped(with productId: Int,
                        with productImage: UIImage,
                        with productName: String,
                        with productQuantity: String,
                        with productPrice: String)
}

class ProductViewCell: UITableViewCell {
    
    weak var delegate: ProductViewCellDelegate?
    public var productId: Int? = nil
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productStockLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    
    private var quantity: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupProductImage()
        
        self.makeTextBold(label: productNameLbl)
        self.makeTextBold(label: productStockLbl)
        self.makeTextBold(label: productPriceLbl)
        self.makeTextBold(label: productQuantityLbl)
        
        self.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func setupProductImage(){
        productImage.layer.borderWidth = 0.5
        productImage.layer.masksToBounds = false
        productImage.layer.borderColor = UIColor.lightGray.cgColor
        productImage.layer.cornerRadius = 15
        productImage.clipsToBounds = true
    }
    
    func makeTextBold(label: UILabel) {
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func minusBtnTapped(_ sender: Any) {
        if self.quantity > 0 {
            self.quantity -= 1
            self.productQuantityLbl.text = "\(self.quantity)"
        }
        
        delegate?.minusBtnTapped(with: self.productId!,
                                 with: self.productImage.image!,
                                 with: self.productNameLbl.text!,
                                 with: self.productQuantityLbl.text!,
                                 with: self.productPriceLbl.text!)
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        self.quantity += 1
        self.productQuantityLbl.text = "\(self.quantity)"
        
        delegate?.plusBtnTapped(with: self.productId!,
                                with: self.productImage.image!,
                                with: self.productNameLbl.text!,
                                with: self.productQuantityLbl.text!,
                                with: self.productPriceLbl.text!)
    }
    
    func setImage(image: UIImage){
        self.productImage.image = image
    }
}
