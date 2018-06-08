
//Comentarys in the class UserModel

import Foundation

class UserModel{
    var id: String!
    var name: String!
    var number: String!
    var email: String!
    var password: String!
    var address: String!
    
    init(id: String!, name: String!, number: String!, email: String!, password: String!, address: String!){
        self.id = id
        self.name = name
        self.number = number
        self.email = email
        self.password = password
        self.address = address
    }
    
}
