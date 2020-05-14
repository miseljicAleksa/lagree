//
//  ProfileController.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/26/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class ProfileController: UITableViewController {
    
    var source:[Session] = []
    
    var addIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationBar(title: "MY LAGREE")
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        //Get sessions from API
        let dm = DataManager()
        dm.getSessions { (json) in
            for (_, item) in json {
                let session = Session(json: item)
                self.source.append(session)
            }
            self.tableView.reloadData()
        }
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat {
            var height:CGFloat = 300.0
        if indexPath.row == 0 {
            //FIRST CELL
            height = 300.0
        } else if indexPath.row > 0 && indexPath.row < source.count + 1 {
            //SECOND CELL
            height = 100.0
        } else if indexPath.row == source.count + 1 {
            //THIRD CELL
            height = 220.0
        }
        return height
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if source.count == 0{
            //If no sessions, table will have 3 rows
            
            return source.count + 3
        }else{
            //If there are sessions, the table will have 2 extra rows
            return source.count + 2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ProfileViewCell? = nil
        
        var addIndex = 1
        if source.count == 0{
            addIndex = 2
        }
        if indexPath.row == 0 {
            //FIRST CELL
            cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as? ProfileViewCell
            print(User.getLoggedUser().first_name)
            print("cell 1")
        } else if indexPath.row > 0 && indexPath.row < source.count + addIndex {
            //SECOND CELL
            cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? ProfileViewCell
            
            if source.count > 0{
                //Show sessions
                print(indexPath.row - 1)
                let session = source[indexPath.row - 1]
                cell?.sessionName.text = session.name
                cell?.sessionImage.setRounded()
                cell?.sessionImage.downloadedFrom(link: session.imageUrl!, contentMode: .scaleAspectFill)
            }else{
                //Show No Upcoming sessions message
                for view in (cell?.contentView.subviews)!{
                    view.removeFromSuperview()
                }
                
                //Title
                let label = UILabel(frame: CGRect(x: 20, y: 20, width: 300, height: 100))
                label.text = "No Upcoming Classes"
                label.textColor = UIColor.gray
                label.font = UIFont.boldSystemFont(ofSize: 19.0)
                //label.font = UIFont(name:"avenirNext-Meduim",size:20)
                cell?.contentView.addSubview(label)
            }
            
            
        } else if indexPath.row == source.count + addIndex {
            //THIRD CELL
            cell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as? ProfileViewCell
            
            print("cell 3")
        }
        cell!.layoutMargins = UIEdgeInsets.zero
        cell!.indentationLevel = 0
        cell!.indentationWidth = 0
        cell!.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addNavigationBar(title: String)
    {
        //Add left menu button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(revealMenu), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
        
        //Add title
        self.navigationItem.title = title
        
        //Add right menu button
        let rightButton = UIButton(type: .custom)
        rightButton.setTitle("BUY CLASSES", for: .normal)
        rightButton.titleLabel?.textColor = UIColor.white
        rightButton.titleLabel?.font = .boldSystemFont(ofSize: 9)
        rightButton.frame = CGRect(x: 0, y: 0, width: 75, height: 20)
        rightButton.setRounded(rad: 10)
        rightButton.setLagreeRedColor()
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        rightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        //Remove bottom border line
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Change background color to white
        //self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
    }
    
    //Open menu
    @objc func revealMenu()
    {
        print("revealMenu")
        self.sideMenuController?.revealMenu()
    }
    
    
    @objc func rightButtonClicked(){
        popupController(id: "BuyMoreClassesController")
    }
    
    
    func popupController(id: String)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: id)
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .fullScreen
        self.present(popUpVC, animated: true, completion: nil)
    }
}
