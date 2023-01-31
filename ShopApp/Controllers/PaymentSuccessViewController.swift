//
//  PaymentSuccessViewController.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/31/23.
//

import UIKit

class PaymentSuccessViewController: UIViewController {
    
    @IBOutlet weak var paymentSuccessLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentSuccessLbl.textColor = .black
        paymentSuccessLbl.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
    
    
    @IBAction func returnBackBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
