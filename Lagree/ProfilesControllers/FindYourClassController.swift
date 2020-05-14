//
//  FindYourClassController.swift
//  Lagree
//
//  Created by alk msljc on 10/7/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

struct  cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String?]()
}


class FindYourClassController: AbstractProfileController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func backButton(_ sender: UIButton) {
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func nextButton(_ sender: Any) {
    }
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    var sectionHeight:CGFloat = 80
    var rowHeight:CGFloat = 60
    
    var selectedRow = -1
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectArray = [Objects]()

    var names = ["What time of day do you prefer to workout?": ["Morning", "Afternone", "Evening", "Anytime"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonOutlet.setLagreeRedColor()
        setBackground()
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.allowsMultipleSelection = true
        //cellData(opened: false, title: "Expand", sectionData: ["What day do you work out?","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Any Day"])]
        for (key, value) in self.names {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let frame = tableView.frame
        
        //Header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: self.sectionHeight))
        
        //Bottom Border
        let borderBottom = UIView(frame: CGRect(x:0, y:self.sectionHeight-1, width: tableView.bounds.size.width, height: 0.5))
        borderBottom.backgroundColor = UIColor.lightGray
        borderBottom.layer.opacity = 0.18
        headerView.addSubview(borderBottom)
        
        //Title
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 300, height: self.sectionHeight))
        label.text = objectArray[section].sectionName
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        //label.font = UIFont(name:"avenirNext-Meduim",size:20)
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let frame = tableView.frame
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}

        cell.isSelected = false
        cell.isHighlighted = false
        
        //Selected row
       
            let cellView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: rowHeight))
            //Change bg color
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.black
            cell.selectedBackgroundView = bgColorView
            //cell.backgroundColor = UIColor.clear
        
        
            
            cell.textLabel?.highlightedTextColor = .white
            //add border and color
            cell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.shadowOpacity = 0.2
            cell.indentationLevel = 0
            cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
            cell.contentView.superview?.addSubview(cellView)
        
            if(indexPath.section == 0 && indexPath.row == self.selectedRow)
               {
                   cell.isSelected = true
                   cell.isHighlighted = true
                   print("Selected row")
               }
        
        
        
       
        
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)!
        
        if(indexPath.section == 0 && self.selectedRow < 0)
        {
            self.selectedRow = indexPath.row
            objectArray.append(Objects(sectionName: "What day do you work out?", sectionObjects:["Monday", "Tuseday"]))
            self.tableView.reloadData()
            
            print(self.selectedRow)
        }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        currentCell.selectedBackgroundView = bgColorView
        currentCell.textLabel?.highlightedTextColor = .white
        currentCell.textLabel?.textColor = .white
        currentCell.accessoryView?.tintColor = UIColor.white
        currentCell.backgroundColor = UIColor.black
        //tableView.updateConstraintsIfNeeded()
        
        currentCell.tintColor = UIColor.white
        currentCell.accessoryType = .checkmark
        
        
    }
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true)
        let currentCell = tableView.cellForRow(at: indexPath)!
        currentCell.backgroundColor = UIColor.clear
        currentCell.accessoryType = .none
        
        currentCell.textLabel?.highlightedTextColor = .black
        currentCell.textLabel?.textColor = .black
        currentCell.backgroundColor = UIColor.clear
    }
        

    

}
