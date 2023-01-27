//
//  LoginViewController.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/20/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(textField: self.emailTxtField)
        setupTextField(textField: self.passwordTxtField)
        
        setupClearButton(textField: self.emailTxtField)
        setupClearButton(textField: self.passwordTxtField)
        
        self.loginBtn.layer.cornerRadius = 10
    }
    
    func setupTextField(textField: UITextField){
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 0.9
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 12
        
        if textField.placeholder == "პაროლი" {
            textField.isSecureTextEntry = true
        }
    }
    
    func setupClearButton(textField: UITextField){
        let clearButton = UIButton(type: .system)
        clearButton.tintColor  = .black
        clearButton.setTitle("X", for: .normal)
        clearButton.addTarget(self, action: #selector(clearTextField),
                              for: .touchUpInside)
        
        textField.rightView = clearButton
        textField.clearButtonMode = .never
        textField.rightViewMode = .whileEditing
    }
    
    @objc func clearTextField(sender: UIButton) {
        if let textField = sender.superview as? UITextField {
            textField.text = ""
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if !isValidEmail(email: emailTxtField.text) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address")
        }
        
        if passwordTxtField.text == "" || passwordTxtField.text == nil {
            showAlert(title: "Invalid Password", message: "Please enter a password")
        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController {
            
//            let currentUserPosts = userPosts[indexPath.section]
//            let currentUserPost = currentUserPosts[indexPath.row]
//
//            vc.postId = currentUserPost.id
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
