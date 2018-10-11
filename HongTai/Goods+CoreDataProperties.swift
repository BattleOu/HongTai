//
//  Goods+CoreDataProperties.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/11.
//  Copyright © 2018年 欧张帆. All rights reserved.
//
//

import Foundation
import CoreData


extension Goods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goods> {
        return NSFetchRequest<Goods>(entityName: "Goods")
    }

    @NSManaged public var goodsid: String?
    @NSManaged public var goodstime: String?
    @NSManaged public var goodsname: String?
    @NSManaged public var morketprice: String?
    @NSManaged public var vipprice: String?
    @NSManaged public var stock: String?
    @NSManaged public var salesnum: String?
    @NSManaged public var goodsimg: String?
    @NSManaged public var introduction: String?
    @NSManaged public var goodsstate: String?

}
