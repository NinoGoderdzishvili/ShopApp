//
//  ProductsViewController.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/24/23.
//

import UIKit

struct ProductModel: Equatable {
    let id: Int
    let image: UIImage
    let name: String
    let quantity: Int
    let price: Int
}

class ProductsViewController: UIViewController {
    
    var cartProducts = [ProductModel]()
    
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var cellProductQtyLbl: UILabel!
    @IBOutlet weak var productQtyLbl: UILabel!
    @IBOutlet weak var productSumPriceLbl: UILabel!
    
    private var productQuantity: Int = 0
    
    var productQuantities = [Int]()
    
    var products = [[Product]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productQtyLbl.text = "0x"
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
    
    @IBAction func goToCart(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            vc.products = self.cartProducts
            vc.subTotal = getSubTotal()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource, ProductViewCellDelegate  {
    
    func minusBtnTapped(with productId: Int,
                        with productImage: UIImage,
                        with productName: String,
                        with productQuantity: String,
                        with productPrice: String) {
        
        if !self.cartProducts.isEmpty {
            
            let quantity = Int(productQuantity)!
            
            if quantity == 0 {
                self.cartProducts.removeAll(where: { $0.id == productId})
                updateLabels()
            } else {
                addOrRemoveProduct(productId: productId,
                                   productImage: productImage,
                                   productName: productName,
                                   quantity: quantity,
                                   productPrice: productPrice)
            }
        }
    }
    
    func plusBtnTapped(with productId: Int,
                       with productImage: UIImage,
                       with productName: String,
                       with productQuantity: String,
                       with productPrice: String) {
        
        let quantity = Int(productQuantity)!
        
        
        addOrRemoveProduct(productId: productId,
                           productImage: productImage,
                           productName: productName,
                           quantity: quantity,
                           productPrice: productPrice)
    }
    
    func addOrRemoveProduct(productId: Int, productImage: UIImage, productName: String, quantity: Int, productPrice: String) {
        guard let price = Int(productPrice.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
            return
        }
        
        let filterdCartProduct = self.cartProducts.filter { $0.id == productId }
        if let cartProduct = filterdCartProduct.first {
            
            self.cartProducts.removeAll(where: { $0.id == cartProduct.id })
            self.cartProducts.append(ProductModel(id: productId, image: productImage, name: productName, quantity: quantity, price: price))
            
        } else {
            self.cartProducts.append(ProductModel(id: productId, image: productImage, name: productName, quantity: quantity, price: price))
        }
        
        updateLabels()
    }
    
    func updateLabels(){
        let totalProdQty = getTotalQtyOfProduct()
        let subTotal = getSubTotal()
        
        self.productQtyLbl.text = "\(totalProdQty)x"
        self.productSumPriceLbl.text = "\(subTotal)$"
    }
    
    func getSubTotal() -> Int {
        let subTotal = self.cartProducts.reduce(0) { (result, product) in
            return result + (product.price * product.quantity)
        }
        
        return subTotal
    }
    
    func getTotalQtyOfProduct() -> Int {
        let totalQuantity = self.cartProducts.reduce(0) { $0 + $1.quantity }
        return totalQuantity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as?
                ProductViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        let products = products[indexPath.section]
        let product = products[indexPath.row]
        
        cell.productId = product.id
        cell.productNameLbl.text = product.title
        cell.productStockLbl.text = "stock: \(product.stock)"
        cell.productPriceLbl.text = "price: \(product.price)"
        cell.productQuantityLbl.text = "0"
        
        print("self.productQuantity: \(self.productQuantity)")
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
}
