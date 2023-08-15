//
//  ContactsDetailsViewController.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//


import UIKit

class ContactsDetailsViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets to connect with the Interface Builder
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    // Variables to store contact data
    var contacts: Contacts!
    var contactsList: ContactsList!
    var phoneNumber: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //kamal67802
        // Setting up delegates for text fields to handle user input
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        // Add a tap gesture to dismiss the keyboard when tapping outside the text fields
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Function to dismiss the keyboard when tapping outside text fields
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method to dismiss keyboard on "Return" key press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // If editing an existing contact, populate text fields with contact details
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
        // Update or create the contact based on user input when leaving the view
        if contacts != nil{
            contacts.firstName = firstNameTextField.text ?? ""
            contacts.lastName = lastNameTextField.text ?? ""
            contacts.phoneNumber = phoneNumberTextField.text ?? ""
        }else{
            // Only create a new contact if at least first name or last name is provided
            if firstNameTextField.text != "" || lastNameTextField.text != ""{
                contactsList.createContact(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, phoneNumber: phoneNumberTextField.text!)
            }
        }
    }
}
