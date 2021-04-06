//
//  User.swift
//  FriendBook
//
//  Created by Kristoffer Eriksson on 2021-04-01.
//

import Foundation

class UserList: ObservableObject {
    
    
    @Published var userList : [User]
    
    init(){
        self.userList = [User]()
    }
    
   
}

struct User: Codable, Hashable {
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    
    var friends: [Friend]
    
}

extension User {
    init(coreDataUser: UserCoreData){
        self.id = coreDataUser.id ?? "no id"
        self.isActive = coreDataUser.isActive
        self.name = coreDataUser.name ?? "no name"
        self.age = Int(coreDataUser.age)
        self.company = coreDataUser.company ?? "no company"
        self.email = coreDataUser.email ?? "no email"
        self.address = coreDataUser.address ?? "no address"
        self.about = coreDataUser.about ?? "no info"
        self.registered = coreDataUser.registered ?? "no reg"
        self.tags = [String]()
        
        
        var friendList = [Friend]()
        for friend in coreDataUser.friendsArray{
            let newFriend = Friend(id: friend.id ?? "no id ", name: friend.name ?? "no friend")
            friendList.append(newFriend)
            
        }
        
        self.friends = friendList
        
    }
}
