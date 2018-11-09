//
//  CartList.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/11/8.
//  Copyright © 2018 欧张帆. All rights reserved.
//

import UIKit

class CartList: NSObject, NSCoding {
    
    var goodsimg:String
    var goodstyle:String
    var goodsname:String
    var introduction:String
    var marketprice:String
    var salesnum:String
    var stock:String
    var userid:String
    var total:String
    var number:String
    var username:String
    
    required init(goodsimg:String = "",goodstyle:String = "", goodsname:String = "", introduction: String = "",marketprice:String = "",salesnum:String = "",stock:String = "",userid:String = "",total:String = "",number:String = "",username:String = ""){
        self.goodsimg = goodsimg
        self.goodstyle = goodstyle
        self.goodsname = goodsname
        self.introduction = introduction
        self.marketprice = marketprice
        self.salesnum = salesnum
        
        self.stock = stock
        self.userid = userid
        self.total = total
        self.number = number
        self.username = username
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.goodsimg = decoder.decodeObject(forKey: "goodsimg") as! String
        self.goodstyle = decoder.decodeObject(forKey: "goodstyle") as! String
        self.goodsname = decoder.decodeObject(forKey: "goodsname")as! String
        self.introduction = decoder.decodeObject(forKey: "introduction")as? String ?? ""
        self.marketprice = decoder.decodeObject(forKey: "marketprice")as? String ?? ""
        self.salesnum = decoder.decodeObject(forKey: "salesnum")as? String ?? ""
        self.stock = decoder.decodeObject(forKey: "stock")as? String ?? ""
        self.userid = decoder.decodeObject(forKey: "userid")as? String ?? ""
        self.total = decoder.decodeObject(forKey: "total")as? String ?? ""
        self.number = decoder.decodeObject(forKey: "number")as? String ?? ""
        self.username = decoder.decodeObject(forKey: "username")as? String ?? ""
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(goodsimg,forKey:"goodsimg")
        coder.encode(goodstyle,forKey:"goodstyle")
        coder.encode(goodsname, forKey: "goodsname")
        coder.encode(introduction, forKey: "introduction")
        coder.encode(marketprice, forKey: "marketprice")
        coder.encode(salesnum, forKey: "salesnum")
        coder.encode(stock, forKey: "stock")
        coder.encode(userid, forKey: "userid")
        coder.encode(total, forKey: "total")
        coder.encode(number, forKey: "number")
        coder.encode(username, forKey: "username")
    }
}
