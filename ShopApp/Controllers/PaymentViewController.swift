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
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentProductViewCell", for: indexPath) as?
                PaymentProductViewCell else {
            return UITableViewCell()
        }
        
        let product = self.products[indexPath.row]
        
        cell.productTitle.text = product.title
        cell.productQuantity.text = "0x"
        cell.productTotalPrice.text = "0$"
      
        let url = URL(string: product.images.first!)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            let image = UIImage(data: data)

            DispatchQueue.main.async {
                cell.prdouctImg.image = image
            }
        }
        task.resume()
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
