//
//  PaymentViewController.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/25/23.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    var products = [ProductModel]()
    var balance = 5000
    var subTotal = 0
    var fee = 30
    var delivery = 50
    
    private var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.total = subTotal + fee + delivery
        
        self.totalPriceLbl.text = "\(subTotal)$"
        self.feeLbl.text = "\(fee)$"
        self.deliveryLbl.text = "\(delivery)$"
        self.totalLbl.text = "\(self.total)$"
        
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    @IBAction func payBtn(_ sender: Any) {
        if self.balance < self.total {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentFailedViewController") as? PaymentFailedViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentSuccessViewController") as? PaymentSuccessViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentProductViewCell", for: indexPath) as?
                PaymentProductViewCell else {
            return UITableViewCell()
        }
        
        let product = self.products[indexPath.row]
        
        cell.productTitle.text = product.name
        cell.productQuantity.text = "\(product.quantity)x"
        cell.productTotalPrice.text = "\(product.price * product.quantity)$"
        cell.prdouctImg.image = product.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
