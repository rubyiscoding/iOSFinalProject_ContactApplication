//
//  ContactTableViewController.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//

import UIKit

class ContactTableViewController: UITableViewController ,UISearchResultsUpdating {
    var contactsList = ContactsList();
    var searchController: UISearchController! // Declare the search controller
    var filteredContacts: [Contacts] = []

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Add search bar to the navigation bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let sortingSegmentedControl = UISegmentedControl(items: ["First Name", "Last Name", "Phone Number"])
                sortingSegmentedControl.addTarget(self, action: #selector(sortingOptionChanged(_:)), for: .valueChanged)
                navigationItem.titleView = sortingSegmentedControl
    }
    @objc func sortingOptionChanged(_ sender: UISegmentedControl) {
           switch sender.selectedSegmentIndex {
           case 0:
               contactsList.sortContactsByFirstName()
           case 1:
               contactsList.sortContactsByLastName()
           case 2:
               contactsList.sortContactsByPhoneNumber()
           default:
               break
           }
           tableView.reloadData()
       }
    // UISearchResultsUpdating method
        func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text?.lowercased() {
                filteredContacts = contactsList.allContacts.filter { contact in
                    return contact.firstName.lowercased().contains(searchText) || contact.lastName.lowercased().contains(searchText)
                }
                tableView.reloadData()
            }
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
            if searchController.isActive {
                return filteredContacts.count
            } else {
                return contactsList.allContacts.count
            }
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath)
            let contact: Contacts
            if searchController.isActive {
                contact = filteredContacts[indexPath.row]
            } else {
                contact = contactsList.allContacts[indexPath.row]
            }
            cell.textLabel!.text = "\(contact.firstName) \(contact.lastName)"
        
            // Apply subtle shadow to the cell
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowOpacity = 0.2
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.contentView.layer.shadowRadius = 4
        
        // Customize cell selection color
            cell.selectionStyle = .default
            cell.selectedBackgroundView = UIView()
            cell.selectedBackgroundView?.backgroundColor = UIColor.lightGray

            return cell
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        let firstName = contactsList.allContacts[indexPath.row].firstName
        let lastName = contactsList.allContacts[indexPath.row].lastName

        print("\(firstName) \(lastName)")
       }
    
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 16, y: -8, width: tableView.frame.width - 16, height: 30)
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        titleLabel.textColor = .black
        titleLabel.text = "Contacts"
        headerView.addSubview(titleLabel)
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // Set the height of the header view
    }



}
