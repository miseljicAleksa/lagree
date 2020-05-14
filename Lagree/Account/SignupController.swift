//
//  SignupController.swift
//  Lepsha
//
//  Created by Milica Stolic on 10/25/18.
//  Copyright © 2018 Software Engineering Institute. All rights reserved.
//

import UIKit

class SignupController: AbstractAccountController {
    

    @IBOutlet weak var progresBar: UIView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var signupButtonStyle: UIButton!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    let dataManager:DataManager = DataManager()
    let background_image_view = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progresBar.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        userEmailTextField.underlined()
        userPasswordTextField.underlined()
        repeatPasswordTextField.underlined()
        signupButtonStyle.setRounded(rad: 5)
        userEmailTextField.keyboardType = UIKeyboardType.emailAddress
        
        
        if #available(iOS 12, *) {
            // iOS 12 & 13: Not the best solution, but it works.
            userPasswordTextField.textContentType = .oneTimeCode
            repeatPasswordTextField.textContentType = .oneTimeCode
        } else {
            // iOS 11: Disables the autofill accessory view.
            // For more information see the explanation below.
            userPasswordTextField.textContentType = .init(rawValue: "")
            repeatPasswordTextField.textContentType = .init(rawValue: "")
        }
        
        //DISMISS KEYBOARD
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        
        setBackground()
        addCustomBar(title: "STUDENT REGISTRATION", back: "IntroController")
        signupButtonStyle.setLagreeRedColor()
        
        // Do any additional setup after loading the view.
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func signupButton(_ sender: Any) {
        
        
        self.infoLabel.text = ""
        let email = userEmailTextField.text
        let password = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        let fbId = "0"
        
        
        // Check for empty field
        if(email!.isEmpty || password!.isEmpty || repeatPassword!.isEmpty) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        
        if(!isValidEmail(testStr: email!))
        {
            // Display alert message
            self.alert(msg: "Email is not valid!".localized)
            return
        }
        
        // Password length
        if(password!.count < 6) {
            // Display alert message
            self.alert(msg: "Password must be between 6 and 20 characters long".localized)
            return
        }
        
        // Password matching
        if(password != repeatPassword) {
            // Display alert message
            self.alert(msg: "Passwords do not match".localized)
            return
        }
        
        
        register(email: email!, fbId: fbId, password: password!)
    }
    



    
    func register(email:String,fbId:String,password:String){
        signupButtonStyle.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.dataManager.register(email: email, fbId: fbId, password: password, fbat: "0", completion:{(json) -> Void in
                let status = json["status"]
                let result = json["result"]
                let message = json["message"]

                if(status == "success"){

                    //Login user
                    let user = User(json: result)
                    user.login()
                    
                    //Go next
                    DispatchQueue.main.async(execute: {
                        self.signupButtonStyle.stopAnimating()
                        AbstractViewController.goToController(modifier: "PersonalInfoController")
                    })
                }else{
                    //Logout user
                    User.logout()

                    DispatchQueue.main.async(execute: {
                        self.signupButtonStyle.stopAnimating()
                        if(message == "0")
                        {
                            // Display alert message
                            self.alert(msg: "The email has been already registered. Please go to login or use another one".localized)
                        }else
                        {
                            // Display alert message
                            self.alert(msg: "Unable to register, please try later".localized)
                        }
                    })
                }
        })
        }
    }



    /// Email syntax validation
    ///
    /// - Parameter testStr: <#testStr description#>
    /// - Returns: <#return value description#>
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /// Random string
    ///
    /// - Parameter length: length string length
    /// - Returns: return value String
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
//    func displayAlertMessage(userMessage:String) {
//
//        let textFieldAlert = UIAlertController(title: "Alert".localized, message: userMessage, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
//
//        textFieldAlert.addAction(okAction)
//
//        self.present(textFieldAlert, animated: true, completion: nil)
//
//    }


}

