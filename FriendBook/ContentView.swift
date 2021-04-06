//
//  ContentView.swift
//  FriendBook
//
//  Created by Kristoffer Eriksson on 2021-04-01.
//

import SwiftUI

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UserCoreData.entity(), sortDescriptors: []) var users: FetchedResults<UserCoreData>
   
    
    @ObservedObject var userList = UserList()
   
    
    var body: some View {
        NavigationView{
            VStack {
                
                Button("Remove users"){
                    for user in users{
                        self.moc.delete(user)
                    }
                    try! self.moc.save()
                    
                    print("deleting users")
                    
                    self.userList.userList = [User]()
                }
                
//                Button("Fetch users"){
//                    self.fetchData()
//
//                }
                
                Text("Welcome to FriendBook")
                    .font(.headline)
                    .foregroundColor(Color.purple.opacity(0.75))
                    .padding()
                
                
                NavigationLink(destination: ListView(userList: userList.userList, userList2: userList)){
                    Text("See Users")
                        .font(.title2)
                        .foregroundColor(Color.red.opacity(0.8))
                    
                }
            }
            .onAppear(perform: {
                fetchData()
            })
        }
    }
    
    func fetchData(){
        
        if users.isEmpty {
            print("nothing saved in core data")
            
            //force unwrap because it is hardtyped
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    if let decodedData = try? JSONDecoder().decode([User].self, from: data){
                        
                        self.userList.userList = decodedData
                        print("successful fetch")
                        
                        for user in self.userList.userList{
                            let newUser = UserCoreData(context: self.moc)
                            newUser.id = user.id
                            newUser.name = user.name
                            newUser.about = user.about
                            newUser.address = user.address
                            newUser.age = Int16(user.age)
                            newUser.company = user.company
                            newUser.isActive = user.isActive
                            newUser.email = user.email
                            newUser.registered = user.registered
                            
                            for friend in user.friends {
                               
                                //newUser.friend = FriendCoreData(context: self.moc)
                                
                                //works
//                                newUser.friends = FriendCoreData(context: self.moc)
//                                newUser.friends?.name = friend.name
//                                newUser.friends?.id = friend.id
                                
                                let newFriend = FriendCoreData(context: self.moc)
                                newFriend.name = friend.name
                                newFriend.id = friend.id
                                newFriend.users = newUser
                                
                                try? self.moc.save()
                            }
                            
                            try? self.moc.save()
                            
                        }
                        print("saved in core data")
                        
                    } else {
                        print("failed to init data")
                    }
                }
                
            }.resume()
            
            
            
        } else {
            print("has stored info")
            
            let newArray = users.map({
                User.init(coreDataUser: $0)
                
            })
            self.userList.userList = newArray

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userList: UserList())
    }
}
