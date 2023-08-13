//
//  ContactsDetailsViewController.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//

import UIKit

class ContactsDetailsViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var contacts: Contacts!
    var contactsList: ContactsList!
    var phoneNumber: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if contacts != nil{
            firstNameTextField.text = contacts.firstName
            lastNameTextField.text = contacts.lastName
            phoneNumberTextField.text = contacts.phoneNumber
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if contacts != nil{
            contacts.firstName = firstNameTextField.text ?? ""
            contacts.lastName = lastNameTextField.text ?? ""
            contacts.phoneNumber = phoneNumberTextField.text ?? ""
        }else{
            if firstNameTextField.text != "" || lastNameTextField.text != ""{
                contactsList.createContact(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, phoneNumber: phoneNumberTextField.text!)
            }
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
