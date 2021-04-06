//
//  FriendCoreData+CoreDataProperties.swift
//  FriendBook
//
//  Created by Kristoffer Eriksson on 2021-04-06.
//
//

import Foundation
import CoreData


extension FriendCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCoreData> {
        return NSFetchRequest<FriendCoreData>(entityName: "FriendCoreData")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var users: UserCoreData?

}

extension FriendCoreData : Identifiable {

}
