//
//  PersonalInfoController.swift
//  Lagree
//
//  Created by alk msljc on 9/15/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class PersonalInfoController: AbstractAccountController {
var names = ["Select Your Nearest Studio": ["Westwood Hollywood", "WestWood", "Santa Monica"]]
    @IBOutlet weak var personalName: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var personalLastname: UITextField!
    
    @IBOutlet weak var personalPhoneNumber: UITextField!
    
    @IBOutlet weak var progresBar: UIView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var nearestStudio: UITextField!
    @IBOutlet weak var personalCity: UITextField!
    
    @IBAction func studioTapped(_ sender: Any) {
        showPopUp()
    }
    @IBAction func closestStudioButton(_ sender: UIButton) {
        showPopUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        progresBar.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        addCustomBar(title: "STUDENT REGISTRATION", back: "SignupController")
        
        personalName.underlined()
        personalLastname.underlined()
        personalPhoneNumber.underlined()
        personalCity.underlined()
        nearestStudio.underlined()
        nextButtonOutlet.setLagreeRedColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        nearestStudio.addTarget(self, action: #selector(showPopUp), for: .touchDown)
        definesPresentationContext = true
    }
    
    
    /// <#Description#>
    @objc func showPopUp() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParentViewController()
        }
        
        let controller = QuickTableController(names) { (section, row) in
            let selectedSection = self.names["Select Your Nearest Studio"] as! [String]
            let studio = selectedSection[row]
            self.nearestStudio.text = studio
        }
        self.present(controller, animated: true)
    }
    
    /// dismissKeyboard
    ///
    /// - Parameter sender: <#sender description#>
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        personalName.resignFirstResponder()
        personalLastname.resignFirstResponder()
        personalPhoneNumber.resignFirstResponder()
        personalCity.resignFirstResponder()
    }
    
    
    /// <#Description#>
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func nextButton(_ sender: UIButton) {
        self.infoLabel.text = ""
        let personalName = self.personalName.text
        let personalLastname = self.personalLastname.text
        let personalPhoneNumber = self.personalPhoneNumber.text
        let personalCity = self.personalCity.text
        let nearestStudio = self.nearestStudio.text
        
        
        // Check for empty field
        if(personalName!.isEmpty || personalLastname!.isEmpty || personalPhoneNumber!.isEmpty || personalCity!.isEmpty || nearestStudio!.isEmpty) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        
        // Check for empty field
        if(!self.isValidPhone(phone: personalPhoneNumber!)) {
            // Display alert message
            self.alert(msg: "Phone number is not valid, please check again".localized)
            return
        }
        
        var data = [NSURLQueryItem()]
        data.removeAll()
        data.append(NSURLQueryItem(name: "first_name", value: personalName))
        data.append(NSURLQueryItem(name: "last_name", value: personalLastname))
        data.append(NSURLQueryItem(name: "phone", value: personalPhoneNumber))
        data.append(NSURLQueryItem(name: "city", value: personalCity))
        data.append(NSURLQueryItem(name: "studio", value: nearestStudio))
        
        updatePersonalInfo(data: data)
    }
    
    
    
    
    
    /// updatePersonalInfo
    ///
    /// - Parameter data: [NSURLQueryItem]
    func updatePersonalInfo(data:[NSURLQueryItem]){
        nextButtonOutlet.startAnimating()
        DispatchQueue.global(qos: .background).async {
            let dataManager = DataManager()
            dataManager.updatePersonalInfo(data: data, completion:{(json) -> Void in
                let status = json["status"]
                let result = json["result"]
                
                if(status == "success"){
                    
                    //Add extra data to user
                    let user = User(json: result)
                    user.login()
                    
                    //Go next
                    DispatchQueue.main.async(execute: {
                        self.nextButtonOutlet.stopAnimating()
                        AbstractViewController.goToController(modifier: "EmergencyContactController")
                    })
                }else{
                    //Logout user
                    User.logout()
                    
                    DispatchQueue.main.async(execute: {
                        self.nextButtonOutlet.stopAnimating()
                            // Display alert message
                        self.alert(msg: "Unable to update info, please try later".localized)
                        
                    })
                }
            })
        }
    }
    
    
    /// isValidPhone
    ///
    /// - Parameter phone: number
    /// - Returns: return bool
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
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
