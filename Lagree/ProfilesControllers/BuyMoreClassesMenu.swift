//
//  MenuController.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/6/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class BuyMoreClassesMenu: AbstractProfileController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToCartButtonOutlet: UIButton!
    
    @IBAction func backBUtton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToFindClassTestVersion(_ sender: UIButton) {
        popupController(id: "FindYourClassController")
    }
    let source = ["1st class Special - $15","1 Class - $25","3 Pack - $71","5 Pack - $99","5 Pack - $121","10 Pack - $140", "20 Pack - $240"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addToCartButtonOutlet.setLagreeRedColor()
        setBackground()
//        menuImage.setRounded()
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
            
            //Change bg color
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.black
            cell.selectedBackgroundView = bgColorView
            cell.backgroundColor = UIColor.clear
            
            let item = source[indexPath.section]
            
            cell.itemTitle.text = item
            cell.itemTitle.highlightedTextColor = UIColor.white
           
            // add border and color
            cell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.shadowOpacity = 0.2
            cell.indentationLevel = 0
            
            return cell
        }
    
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currentCell = tableView.cellForRow(at: indexPath)!
            currentCell.accessoryType = .checkmark
            currentCell.backgroundColor = UIColor.black
            tableView.updateConstraintsIfNeeded()
        }
        
        
         func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            let currentCell = tableView.cellForRow(at: indexPath)!
            currentCell.backgroundColor = UIColor.clear
            currentCell.accessoryType = .none
        }

}
