//
//  PersonalInfoController.swift
//  Lagree
//
//  Created by alk msljc on 9/15/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class PersonalInfoController: AbstractViewController {
var names = ["Select Your Nearest Studio": ["Westwood Hollywood", "WestWood", "Santa Monica"]]
    @IBAction func closestStudioButton(_ sender: UIButton) {
        let controller = QuickTableController(names) { (row, section) in
            print(section)
        }
        self.present(controller, animated: true)
    }
    @IBOutlet weak var personalName: UITextField!
    
    @IBOutlet weak var personalLastname: UITextField!
    
    @IBOutlet weak var personalPhoneNumber: UITextField!
    
    @IBOutlet weak var progresBar: UIView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var nearestStudio: UITextField!
    @IBOutlet weak var personalCity: UITextField!
    @IBAction func nextButton(_ sender: UIButton) {
        AbstractViewController.goToController(modifier: "EmergencyContactController")
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
        
        nearestStudio.text =
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
