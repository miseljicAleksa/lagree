//
//  EmergencyContactViewController.swift
//  Lagree
//
//  Created by alk msljc on 9/16/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit
import ContactsUI

class EmergencyContactViewController: AbstractAccountController, CNContactPickerDelegate  {
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var progresBar: UIView!
    @IBOutlet weak var completeRegistrationOutlet: UIButton!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBAction func importFromContacts(_ sender: Any) {
        self.loader.startAnimating()
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        addCustomBar(title: "STUDENT REGISTRATION", back: "PersonalInfoController")
        
        contactNumber.underlined()
        contactName.underlined()
        progresBar.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        completeRegistrationOutlet.setLagreeRedColor()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        contactName.resignFirstResponder()
        phoneNumber.resignFirstResponder()
    }
    
    // MARK: Delegate method CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
       
        let numbers = contact.phoneNumbers.first
        let name = contact.givenName + " " + contact.familyName
        contactName.text = name
        phoneNumber.text = (numbers?.value)?.stringValue ?? ""
        
        self.loader.stopAnimating()
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CompleteRegistrationButton(_ sender: UIButton) {
        self.infoLabel.text = ""
        let personalName = self.contactName.text
        let personalPhoneNumber = self.phoneNumber.text
        
        
        // Check for empty field
        if(personalName!.isEmpty || personalPhoneNumber!.isEmpty) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        var data = [NSURLQueryItem()]
        data.removeAll()
        data.append(NSURLQueryItem(name: "name", value: personalName))
        data.append(NSURLQueryItem(name: "phone", value: personalPhoneNumber))
        
        updateEmergencyContact(data: data)
    }
    
    func updateEmergencyContact(data:[NSURLQueryItem]){
        completeRegistrationOutlet.startAnimating()
        DispatchQueue.global(qos: .background).async {
            
            let dataManager = DataManager()
            dataManager.updateEmergencyContact(data: data, completion:{(json) -> Void in
                let status = json["status"]
                let result = json["result"]
                
                if(status == "success"){
                    
                    //Add extra data to user
                    let user = User(json: result)
                    user.login()
                    
                    //Go next
                    DispatchQueue.main.async(execute: {
                        self.completeRegistrationOutlet.stopAnimating()
                        AbstractViewController.goToController(modifier: "TermsAndConditionsController")
                    })
                }else{
                    //Logout user
                    User.logout()
                    
                    DispatchQueue.main.async(execute: {
                        self.completeRegistrationOutlet.stopAnimating()
                        // Display alert message
                        self.alert(msg: "Unable to update info, please try later".localized)
                        
                    })
                }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //copied from account/abstactView
  
}
