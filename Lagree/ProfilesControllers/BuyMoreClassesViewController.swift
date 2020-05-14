//
//  BuyMoreClassesViewController.swift
//  Lagree
//
//  Created by alk msljc on 10/1/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class BuyMoreClassesViewController: AbstractProfileController {
    @IBAction func selectPackageButton(_ sender: UIButton) {
        popupController(id: "BuyMoreClassesMenu")
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var selectPackageButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPackageButtonOutlet.setLagreeRedColor()
        setBackground(img: "buyMoreClassesBg")
    
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
