//
//  TermsAndConditionsController.swift
//  Lagree
//
//  Created by alk msljc on 9/24/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class TermsAndConditionsController: AbstractAccountController {
    
    
    @IBOutlet weak var uiButton: UIButton!
    @IBOutlet weak var uiTextView: UITextView!
    @IBOutlet weak var headLabel: UILabel!
    @IBAction func goToProfileButton(_ sender: UIButton) {
        let stringLength:Int = self.uiTextView.text.characters.count
        uiTextView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
        setAcceptButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackground()
        addCustomBar(title: "Terms & Conditions", back: "EmergencyContactController")

    }
    
    @objc func accept (sender: UIButton)
    {
        AbstractViewController.goToController(modifier: "TabBarController", menu:true)
    }
    
    func setAcceptButton() {
        uiButton.addTarget(self, action: #selector(accept(sender:)), for:.touchUpInside)
        uiButton.backgroundColor = .red
        uiButton.borderColor = .white
        uiButton.setTitleColor(UIColor.white, for: .normal)
        uiButton.setTitle("I ACCEPT", for: .normal)
        uiButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        

        
    }
    func setScrollButton() {
        
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
