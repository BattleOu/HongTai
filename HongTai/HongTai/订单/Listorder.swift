//
//  Listorder.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/11/14.
//  Copyright © 2018 欧张帆. All rights reserved.
//

import UIKit

class Listorder: NSObject, NSCoding {
    var getadress: String
    var getpeople: String
    var getphone: String
    var goodimage: String
    var goodnumber: String
    var goodprice: String
    var goodsname: String
    var goodtotal: String
    var ordersid: String
    var ordersmoney: String
    var orderstate: String
    var ordertime: String
    var username: String
    required init(getadress:String = "",getpeople:String = "", getphone:String = "", goodimage: String = "",goodnumber:String = "",goodprice:String = "",goodsname:String = "",goodtotal:String = "",ordersid:String = "",ordersmoney:String = "",orderstate:String = "",ordertime:String = "",username:String = ""){
        self.getadress = getadress
        self.getpeople = getpeople
        self.getphone = getphone
        self.goodimage = goodimage
        self.goodnumber = goodnumber
        self.goodprice = goodprice
        self.goodsname = goodsname
        self.goodtotal = goodtotal
        self.ordersid = ordersid
        self.ordersmoney = ordersmoney
        self.orderstate = orderstate
        self.ordertime = ordertime
        self.username = username
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.getadress = decoder.decodeObject(forKey: "getadress") as! String
        self.getpeople = decoder.decodeObject(forKey: "getpeople") as! String
        self.getphone = decoder.decodeObject(forKey: "getphone")as! String
        self.goodimage = decoder.decodeObject(forKey: "goodimage")as! String
        self.goodnumber = decoder.decodeObject(forKey: "goodnumber")as! String
         self.goodprice = decoder.decodeObject(forKey: "goodprice")as! String
         self.goodsname = decoder.decodeObject(forKey: "goodsname")as! String
         self.goodtotal = decoder.decodeObject(forKey: "goodtotal")as! String
         self.ordersid = decoder.decodeObject(forKey: "ordersid")as! String
         self.ordersmoney = decoder.decodeObject(forKey: "ordersmoney")as! String
         self.orderstate = decoder.decodeObject(forKey: "orderstate")as! String
         self.ordertime = decoder.decodeObject(forKey: "ordertime")as! String
         self.username = decoder.decodeObject(forKey: "username")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(getadress,forKey:"getadress")
        coder.encode(getpeople,forKey:"getpeople")
        coder.encode(getphone, forKey: "getphone")
        coder.encode(goodimage, forKey: "goodimage")
        coder.encode(goodnumber, forKey: "goodnumber")
        coder.encode(goodprice, forKey: "goodprice")
        coder.encode(goodsname, forKey: "goodsname")
        coder.encode(goodtotal, forKey: "goodtotal")
        coder.encode(ordersid, forKey: "ordersid")
        coder.encode(ordersmoney, forKey: "ordersmoney")
        coder.encode(orderstate, forKey: "orderstate")
        coder.encode(ordertime, forKey: "ordertime")
        coder.encode(username, forKey: "username")
    }
    
}
