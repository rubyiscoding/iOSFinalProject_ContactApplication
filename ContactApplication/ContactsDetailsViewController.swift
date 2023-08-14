//
//  ContactsDetailsViewController.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//


import UIKit

class ContactsDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var contacts: Contacts!
    var contactsList: ContactsList!
    var phoneNumber: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        //kamal67802
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
        // UITextFieldDelegate method to dismiss keyboard on "Return" key press
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
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
}
