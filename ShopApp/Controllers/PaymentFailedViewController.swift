//
//  PaymentFailedViewController.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/31/23.
//

import UIKit

class PaymentFailedViewController: UIViewController {
    
    @IBOutlet weak var paymentFailedLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentFailedLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        paymentFailedLbl.numberOfLines = 0
        paymentFailedLbl.text = "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან."
        paymentFailedLbl.textColor = .black
        paymentFailedLbl.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
    
    @IBAction func returnBackBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
