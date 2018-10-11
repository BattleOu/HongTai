//
//  Orders+CoreDataProperties.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/11.
//  Copyright © 2018年 欧张帆. All rights reserved.
//
//

import Foundation
import CoreData


extension Orders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Orders> {
        return NSFetchRequest<Orders>(entityName: "Orders")
    }

    @NSManaged public var orderid: String?
    @NSManaged public var userid: String?
    @NSManaged public var getpeople: String?
    @NSManaged public var getpeoplephone: String?
    @NSManaged public var getadress: String?
    @NSManaged public var ordertime: String?
    @NSManaged public var orderstate: String?
    @NSManaged public var ordermoney: String?
    @NSManaged public var deliverytype: String?
    @NSManaged public var paymenttype: String?
    @NSManaged public var userorders: User?

}
