//
//  Collect+CoreDataProperties.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/11.
//  Copyright © 2018年 欧张帆. All rights reserved.
//
//

import Foundation
import CoreData


extension Collect {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collect> {
        return NSFetchRequest<Collect>(entityName: "Collect")
    }

    @NSManaged public var collectid: String?
    @NSManaged public var userid: String?
    @NSManaged public var goodsid: String?
    @NSManaged public var collectupdate: String?
    @NSManaged public var usercollect: User?
    @NSManaged public var goodscollect: Goods?

}
