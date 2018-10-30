//
//  Styleinfo.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/29.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class Styleinfo: NSObject, NSCoding {
    var goodsid:String
    var goodsimg:String
    var goodstyle:String
    var goodsname:String
    var goodstime:String
    var introduction:String
    var marketprice:String
    var salesnum:String
    var stock:String
    //构造方法
    required init(goodsid:String = "",goodsimg:String = "",goodstyle:String = "", goodsname:String = "", goodstime:String = "", introduction: String = "",marketprice:String = "",salesnum:String = "",stock:String = ""){
        self.goodsid = goodsid
        self.goodsimg = goodsimg
        self.goodstyle = goodstyle
        self.goodsname = goodsname
        
        self.goodstime = goodstime
        self.introduction = introduction
        self.marketprice = marketprice
        self.salesnum = salesnum
        
        self.stock = stock
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.goodsid = decoder.decodeObject(forKey: "goodsid") as! String
        self.goodsimg = decoder.decodeObject(forKey: "goodsimg") as! String
         self.goodstyle = decoder.decodeObject(forKey: "goodstyle") as! String
        self.goodsname = decoder.decodeObject(forKey: "goodsname")as! String
        self.goodstime = decoder.decodeObject(forKey: "goodstime")as? String ?? ""
        self.introduction = decoder.decodeObject(forKey: "introduction")as? String ?? ""
        self.marketprice = decoder.decodeObject(forKey: "marketprice")as? String ?? ""
        self.salesnum = decoder.decodeObject(forKey: "salesnum")as? String ?? ""
        self.stock = decoder.decodeObject(forKey: "stock")as? String ?? ""
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(goodsid,forKey:"goodsid")
        coder.encode(goodsimg,forKey:"goodsimg")
        coder.encode(goodstyle,forKey:"goodstyle")
        coder.encode(goodsname, forKey: "goodsname")
        coder.encode(goodstime, forKey: "goodstime")
        coder.encode(introduction, forKey: "introduction")
        coder.encode(marketprice, forKey: "marketprice")
        coder.encode(salesnum, forKey: "salesnum")
        coder.encode(stock, forKey: "stock")
    }
}
