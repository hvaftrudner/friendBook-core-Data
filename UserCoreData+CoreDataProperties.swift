//
//  UserCoreData+CoreDataProperties.swift
//  FriendBook
//
//  Created by Kristoffer Eriksson on 2021-04-06.
//
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var friends: NSSet?
    
    public var friendsArray: [FriendCoreData]{
        let set = friends as? Set<FriendCoreData> ?? []
        
        return set.sorted{
            $0.name ?? "noname" < $1.name ?? "nonane 2"
        }
    }

}

// MARK: Generated accessors for friends
extension UserCoreData {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendCoreData)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendCoreData)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension UserCoreData : Identifiable {

}
