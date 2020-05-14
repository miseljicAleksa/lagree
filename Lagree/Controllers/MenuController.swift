//
//  MenuController.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/6/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var cashBalanceView: UIView!
    
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var containerVIew: UIView!
    @IBOutlet weak var referFriendButtonOutlet: UIButton!
    @IBOutlet weak var findClassButtonOutlet: UIButton!
    
    @IBAction func findClassButton(_ sender: UIButton) {
    }
    @IBAction func referFriendButton(_ sender: UIButton) {
    }
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let source = ["Personal Info","Billing Info","My Agreements","Payment History","Shop","Have a Question?"]

    override func viewDidLoad() {
        //get user stuff
        let current_user = User.getLoggedUser()
        
        
        hiLabel.text = "Hi,  \(User.getLoggedUser().first_name)!"
        roleLabel.layer.masksToBounds = true
        roleLabel.layer.cornerRadius = 7
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        menuImage.setRounded()
        menuImage.downloadedFrom(link: current_user.image)
        findClassButtonOutlet.setLagreeRedColor()

        
        
                    
            
        
            
   
        // Do any additional setup after loading the view.
    }
    
    
    
    //Table delegate functions
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return source.count;
        }
        
        // There is just one row in every section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        // Set the spacing between sections
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 1.0
        }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70
       }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
            
            let item = source[indexPath.section]
            
            cell.itemTitle.text = item
           
            // add border and color
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.shadowOpacity = 0.2
            cell.indentationLevel = 0
            
            return cell
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            switch indexPath.section {
            case 0:
                //AbstractViewController.goToController(modifier:"")
                break
            default:
                return
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

}
