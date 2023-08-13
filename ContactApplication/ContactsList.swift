//
//  ContactsList.swift
//  ContactApplication
//
//  Created by Pink Zen on 2023-07-05.
//

import Foundation

class ContactsList{
    var allContacts = [Contacts]()
    init(){
        let firstName = ["Amy","John"]
        let lastName = ["Adams","Doe"]
        let phoneNumber = ["3654402624","9842035766"]
        
        let names_with_index = firstName.enumerated()
                for (index,_) in names_with_index {
                    allContacts.append(Contacts(firstName: firstName[index], lastName: lastName[index], phoneNumber: phoneNumber[index]))
                }
    }
    
    func deleteContact(index: Int){
        allContacts.remove(at: index)
    }
    func moveContact(from fromIndex: Int, to toIndex: Int){
        let temp = allContacts[fromIndex]
        allContacts.remove(at: fromIndex)
        allContacts.insert(temp, at:toIndex)
    }
    
    @discardableResult func createContact(firstName:String, lastName:String,phoneNumber:String) -> Contacts {
        let contact = Contacts(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        allContacts.append(contact)
        return contact
    }
    
}
