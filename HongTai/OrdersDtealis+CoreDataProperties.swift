//
//  OrdersDtealis+CoreDataProperties.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/11.
//  Copyright © 2018年 欧张帆. All rights reserved.
//
//

import Foundation
import CoreData


extension OrdersDtealis {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrdersDtealis> {
        return NSFetchRequest<OrdersDtealis>(entityName: "OrdersDtealis")
    }

    @NSManaged public var orderdetailid: String?
    @NSManaged public var goodsid: String?
    @NSManaged public var ordersid: String?
    @NSManaged public var goodsnum: String?
    @NSManaged public var goodsprice: String?
    @NSManaged public var ordersdetail: Orders?
    @NSManaged public var goodsdetail: Goods?

}
