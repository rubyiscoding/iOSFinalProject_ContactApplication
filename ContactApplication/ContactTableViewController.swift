//
//  ContactTableViewController.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//

import UIKit

class ContactTableViewController: UITableViewController {
    var contactsList = ContactsList();

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactsList.allContacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath)
        var firstName = contactsList.allContacts[indexPath.row].firstName
        var lastName = contactsList.allContacts[indexPath.row].lastName
        var phoneNumber = contactsList.allContacts[indexPath.row].phoneNumber
        cell.textLabel!.text = "\(firstName) \(lastName)"

          // Configure the cell...
          return cell
      }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        let index = indexPath.row
        var firstName = contactsList.allContacts[indexPath.row].firstName
        var lastName = contactsList.allContacts[indexPath.row].lastName

        print("\(firstName) \(lastName)")
       }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contactsList.deleteContact(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        contactsList.moveContact(from: fromIndexPath.row, to: to.row)
    }
   

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
        let dst = segue.destination as! ContactsDetailsViewController
        if segue.identifier == "add"{
            //let contact = contactsList.createContact()
            dst.contactsList = contactsList
        }
        else if(segue.identifier == "edit"){
            let index = tableView.indexPathForSelectedRow!.row
            let contacts = contactsList.allContacts[index]
            dst.contacts = contacts
        }
        else{
            preconditionFailure("Segue Identifier Not Known")
        }
        
    }

}
