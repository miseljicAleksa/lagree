//
//  profilePageController.swift
//  Lagree
//
//  Created by alk msljc on 9/24/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class profilePageController: AbstractViewController {
    
    
var names = ["Select Your Nearest Studio": ["Westwood Hollywood", "WestWood", "Santa Monica"]]
    
    
    @IBAction func menu(_ sender: UIButton) {
        
        //self.sideMenuController?.revealMenu()
        
        let controller = QuickTableController(names) { (row, section) in
            print(section)
        }
        self.present(controller, animated: true)
        
        //self.present(PopUp1Controller(), animated: true)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
