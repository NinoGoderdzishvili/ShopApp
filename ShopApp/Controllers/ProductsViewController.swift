//
//  ProductsViewController.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/24/23.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var productQtyLbl: UILabel!
    @IBOutlet weak var productSumPriceLbl: UILabel!
    
    var products = [[Product]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productQtyLbl.text = "0"
        productQtyLbl.textColor = .white
        productQtyLbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        productSumPriceLbl.text = "0$"
        productSumPriceLbl.textColor = .white
        productSumPriceLbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        setupTableView()
        getProducts()
    }
    
    func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    func getProducts() {
        NetworkService.shared.getData(
            urlString: "https://dummyjson.com/products",
            expecting: ProductResponseModel.self) { result in
                switch result {
                case .success(let productResponse):
                    DispatchQueue.main.async {
                        let products = productResponse.products.group(by: {$0.category})
                        self.products = products
                        self.productsTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as?
                ProductViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        let products = products[indexPath.section]
        let product = products[indexPath.row]

        cell.productNameLbl.text = product.title
        cell.productStockLbl.text = "stock: \(product.stock)"
        cell.productPriceLbl.text = "price: \(product.price)"
        cell.productQuantityLbl.text = "0"

        let url = URL(string: product.images.first!)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            let image = UIImage(data: data)

            DispatchQueue.main.async {
                cell.productImage.image = image
            }
        }
        task.resume()
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = products[section]
        return products.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if self.products.count > 0 {
            let products = products[section]
            let product = products.first!
            
            label.text = product.category.capitalized
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func getData(data: Any) {
        self.productQtyLbl.text = data as? String
    }
}
