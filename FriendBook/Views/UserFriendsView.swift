//
//  UserFriendsView.swift
//  FriendBook
//
//  Created by Kristoffer Eriksson on 2021-04-03.
//

import SwiftUI

struct UserFriendsView: View {
    
    @ObservedObject var userList: UserList
    var friends: [Friend]
    
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                ForEach(friends, id: \.self){ friend in
                    // use profile picture
                    let newUser = userList.userList.first(where: {$0.id == friend.id})
                    NavigationLink(destination: UserDetailView(userList: userList, user: newUser!)){
                        VStack{
                            Text(friend.name)
                            Text("age: \(newUser!.age)")
                                .font(.caption2)
                        }
                    }
                    .border(Color.orange, width: 1)
                }
            }
        }
    }
    
    
}

//struct UserFriendsView_Previews: PreviewProvider {
//
//    static let friends = [Friend]()
//    static let testUser = User(id: "", isActive: true, name: "", age: 4, company: "", email: "", address: "", about: "", registered: "", tags: [""], friends: [Friend(id: "", name: ""), Friend(id: "5", name: "5")])
//
//    static var previews: some View {
//        UserFriendsView(friends: friends, friendLink: testUser)
//    }
//}
