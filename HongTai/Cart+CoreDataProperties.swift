//
//  Cart+CoreDataProperties.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/11.
//  Copyright © 2018年 欧张帆. All rights reserved.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var cartid: String?
    @NSManaged public var userid: String?
    @NSManaged public var goodsid: String?
    @NSManaged public var goodsnum: String?
    @NSManaged public var total: String?
    @NSManaged public var cartuser: User?
    @NSManaged public var goodscart: Goods?

}
