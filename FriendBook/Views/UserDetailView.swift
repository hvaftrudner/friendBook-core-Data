//
//  UserDetailView.swift
//  FriendBook
//
//  Created by Kristoffer Eriksson on 2021-04-03.
//

import SwiftUI

struct UserDetailView: View {
    
    @ObservedObject var userList : UserList
    var user: User
    
    var body: some View {
        
            VStack{
                Section{
                    HStack{
                        Text(user.name)
                            .font(.largeTitle)
                            .padding()
                        
                        Spacer()
                        
                        Text(user.isActive ? "Active" : "Not Active")
                            .foregroundColor(user.isActive ? Color.green : Color.red)
                            .padding()
                    }
                    .frame(height: 50)
                    .border(Color.black, width: 2)
                }
                
                Section{
                    HStack{
                        
                        VStack {
                            Text("Description")
                                .font(.title2)
                            ScrollView(.vertical){
                                Text(user.about)
                            }
                        }
                        
                        VStack{
                            Text("Friends")
                                .font(.title2)
                            
                            UserFriendsView(userList: userList, friends: user.friends)
                                .border(Color.red, width: 1)
                                .frame(width: 140)
                        }
                    }
                }
                
                Section{
                    VStack(alignment: .leading){
                        Text("Age: \(user.age)")
                        
                        Text("Contact: \(user.email)")
                        
                        Text("Address: \(user.address)")
                    }
                }
            }
        
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UserDetailView(user: constant(User))
//    }
//}
