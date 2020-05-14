//
//  LoginController.swift
//  Lepsha
//
//  Created by Arsen Leontijevic on 06/03/2017.
//  Copyright © 2017 Software Engineering Institute. All rights reserved.
//

import UIKit

class LoginController: AbstractAccountController, UITextFieldDelegate {
    
        
    
    @IBOutlet weak var charLimit: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginButtonStyle: UIButton!
    
    
    let background_image_view = UIImageView()
    
    
    //ACTIONS
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        AbstractViewController.goToController(modifier: "ForgotPasswordController")
    }
    
    @IBAction func login(_ sender: Any) {
        infoLabel.text = ""
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        signin(email: userEmail!, password: userPassword!);
    }
    
    
    let dataManager:DataManager = DataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPasswordTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        userEmailTextField.underlined()
        userPasswordTextField.underlined()
        userEmailTextField.keyboardType = UIKeyboardType.emailAddress
        setBackground()
        addCustomBar(title: "", back: "IntroController")
        loginButtonStyle.setLagreeRedColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        charLimit.isHidden = true
        print(23232)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
     
     if textField.text!.isEmpty {
         charLimit.isHidden = false
     } else {
         charLimit.isHidden = true
     }
 }
   
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
    }
    
    
    @IBAction func backToLogin(sender: UIStoryboardSegue) {
        
    }
    
    
    //new
    //REGISTER TO SERVER AND REDIRECT TO TABBAR
    func signin(email:String,password:String){
        
        // Check for empty field
        if(email.isEmpty || password.isEmpty) {
            // Display alert message
            alert(msg: "All fields are required!".localized)
            return
        }
        
        if(!isValidEmail(testStr: email))
        {
            // Display alert message
            alert(msg: "Email is not valid!".localized)
            return
        }
        
        //temp
        DispatchQueue.main.async(execute: {
            self.loginButtonStyle.stopAnimating()
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            window.showViewControllerWith(withIdentifier: "TabBarController", usingAnimation: .ANIMATE_LEFT, menu: true)
            
        })
        return
        
        loginButtonStyle.startAnimating()
        DispatchQueue.global(qos: .background).async {
            
            self.dataManager.signin(email: email, password: password, completion:{(json) -> Void in
                let status = json["status"]
                let result = json["result"]
                
                //SET USER DATA
                if(status == "success"){
                    let user = User(json: result)
                    user.login()
                    DispatchQueue.main.async(execute: {
                        self.loginButtonStyle.stopAnimating()
                        guard let window = UIApplication.shared.keyWindow else {
                            return
                        }
                        window.showViewControllerWith(withIdentifier: "TabBarController", usingAnimation: .ANIMATE_LEFT, menu: true)
                        
                    })
                }else{
                    //RESET SETTINGS
                    User.logout()
                    DispatchQueue.main.async(execute: {
                        self.loginButtonStyle.stopAnimating()
                        self.alert(msg: "Email or password is incorrect.".localized)
                    })
                    
                }
            })
        }
    }
    
    
    
    /// Check if email is valid
    ///
    /// - Parameter testStr: testStr eamil address
    /// - Returns: return Bool
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    /// randomString
    ///
    /// - Parameter length: String size
    /// - Returns: Random string
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
    
        return randomString
    }
    
    
    @objc func forgotPass(){
        if let url = URL(string: "https://lepsha.com/forgotpass") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
