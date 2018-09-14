//
//  SubscribersTableViewController.swift
//  iOSDemoAppForSoracomAPI
//
//  Created by Christian Inkster on 12/9/18.
//  Copyright © 2018 Soracom, Inc. All rights reserved.
//

import UIKit

class SubscribersTableViewController: UITableViewController {

    var sandboxMode = true
    var subscribers: SubscriberList = []
    
    fileprivate func loadSubscribers() {
        let req = Request.listSubscribers()
        
        req.responseHandler = { (response) in
            if let error = response.error {
                print("Error: \(response) \(error)")
            } else {
                if let subs = response.parse(){
                    print("Subs: \(subs)")
                    self.subscribers = subs
                    self.tableView.reloadData()
                } else {
                    print("Couldnt extract subs")
                }
            }
        }
        
        req.run()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSubscribers()
        
        if (sandboxMode){
            let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed(sender:)))
            self.navigationItem.rightBarButtonItem = addbutton
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Appearing!")
        self.tableView.reloadData()
    }

    @objc func addButtonPressed( sender: UIBarButtonItem ){
        Client.sharedInstance.createSandboxSIM(){
            (result) in
            if result {
                self.loadSubscribers()
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subscribers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriberCell", for: indexPath)

        let sub = self.subscribers[indexPath.row]
        
        cell.textLabel?.text = sub.imsi
        cell.detailTextLabel?.text = "\(sub.status ?? "Unknown") \(sub.speedClass ?? "Unknown")"

        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let dest = segue.destination as? SubscriberDetailTableViewController, let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        dest.sub = self.subscribers[indexPath.row]
        
    }
 

}
