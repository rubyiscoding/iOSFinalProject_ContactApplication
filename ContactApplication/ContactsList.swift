//
//  ContactsList.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//

import Foundation

class ContactsList{
    // An array to store all contacts
    var allContacts = [Contacts]()
    // Initializer to populate initial contacts
    init(){
        // Sample data for initial contacts
        let firstName = ["Amy","John", "Zion", "Queen", "Martha", "Ruby", "Eddie"]
        let lastName = ["Adams","Doe", "Wick","Baba","Stewart","Chaulagain","Vedder"]
        let phoneNumber = ["3654402624","9842035766", "657278347", "908762389", "729989255", "231908654", "205637889"]
        
        // Create contacts from sample data and add to the list
        let names_with_index = firstName.enumerated()
        for (index,_) in names_with_index {
            allContacts.append(Contacts(firstName: firstName[index], lastName: lastName[index], phoneNumber: phoneNumber[index]))
        }
    }
    
    // Method to delete a contact at a given index
    func deleteContact(index: Int){
        allContacts.remove(at: index)
    }
    
    // this method is used to move a contact from one index to another
    func moveContact(from fromIndex: Int, to toIndex: Int){
        let temp = allContacts[fromIndex]
        allContacts.remove(at: fromIndex)
        allContacts.insert(temp, at:toIndex)
    }
    
    // Method to create a new contact and add it to the list
    @discardableResult func createContact(firstName:String, lastName:String,phoneNumber:String) -> Contacts {
        let contact = Contacts(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        allContacts.append(contact)
        return contact
    }
    
    // Sort contacts by first name //kamal67802
    func sortContactsByFirstName() {
        allContacts.sort { $0.firstName < $1.firstName }
    }
    
    // Sort contacts by last name // kamal67802
    func sortContactsByLastName() {
        allContacts.sort { $0.lastName < $1.lastName }
    }
    
    // Sort contacts by phone number //kamal67802
    func sortContactsByPhoneNumber() {
        allContacts.sort { $0.phoneNumber < $1.phoneNumber }
    }
}
