//
//  ForgotPasswordController.swift
//  Lagree
//
//  Created by alk msljc on 9/17/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class ForgotPasswordController:  AbstractAccountController{

    @IBOutlet weak var resetPasswordOutlet: UIButton!
   
    @IBOutlet weak var resetPassword: UITextField!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        resetPassword.underlined()
        setBackground()
        addCustomBar(title: "", back: "LoginController")
        resetPasswordOutlet.setLagreeRedColor()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        resetPassword.resignFirstResponder()
    }
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        self.infoLabel.text = ""
        let resetEmail = self.resetPassword.text
        
        // Check for empty field
        if(resetEmail!.isEmpty) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        if(!isValidEmail(testStr: resetEmail!))
        {
            // Display alert message
            self.alert(msg: "Email is not valid!".localized)
            return
        }
        var data = [NSURLQueryItem()]
        data.removeAll()
        data.append(NSURLQueryItem(name: "email", value: resetEmail))
        
        resetPassword(data: data)
    }
    
    func resetPassword(data:[NSURLQueryItem]){
        resetPasswordOutlet.startAnimating()
        DispatchQueue.global(qos: .background).async {
            
            let dataManager = DataManager()
            dataManager.resetPassword(data: data, completion:{(json) -> Void in
                let status = json["status"]
                
                DispatchQueue.main.async(execute: {
                    self.resetPasswordOutlet.stopAnimating()
                    
                    if(status == "success"){
                        // Display alert message
                        self.alert(msg: "The password reset link has been sent to your email".localized)
                        
                    }else{
                        
                        // Display alert message
                        self.alert(msg: "We're unable to find your account, please check the email address again".localized)
                    }
                    
                    
                })
                
            })
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
