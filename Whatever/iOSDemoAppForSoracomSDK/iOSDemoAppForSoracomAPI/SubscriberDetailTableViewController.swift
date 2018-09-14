//
//  SubscriberDetailTableViewController.swift
//  iOSDemoAppForSoracomAPI
//
//  Created by Christian Inkster on 13/9/18.
//  Copyright © 2018 Soracom, Inc. All rights reserved.
//

import UIKit

class SubscriberDetailTableViewController: UITableViewController {

    var sub : Subscriber?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let activeSub = self.sub {
            
            self.title = activeSub.imsi
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        cell.accessoryType = .none
        // Configure the cell...
        if (cell.textLabel?.text == sub?.speedClass){
            cell.accessoryType = .checkmark
        }

        return cell
    }
 
    // Change the speed class?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let selectedSpeed = cell?.textLabel?.text else {
            return
        }
        
        if selectedSpeed == sub?.speedClass {
            // just pressing the same class so return
            return
        }
        
        self.changeSpeedClass(speedClass: selectedSpeed)
        
    }
    
    func changeSpeedClass(speedClass:String){
        
        guard let activeSub = self.sub else {
            return
        }
        
        let req = Request.updateSpeedClass(activeSub.imsi ?? "", speedClass: UpdateSpeedClassRequest.SpeedClass(rawValue: speedClass)!){
            (response) in
            
            if let error = response.error {
                print("Error: \(response) \(error)")
            } else {
                activeSub.speedClass = speedClass
                self.navigationController?.popViewController(animated: true)
            }
        }
            
        req.run();
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

}
