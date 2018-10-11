//
//  User+CoreDataProperties.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/11.
//  Copyright © 2018年 欧张帆. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userid: String?
    @NSManaged public var username: String?
    @NSManaged public var userpassword: String?
    @NSManaged public var userrelaname: String?
    @NSManaged public var userimage: String?
    @NSManaged public var birthday: String?
    @NSManaged public var userupdate: String?

}
