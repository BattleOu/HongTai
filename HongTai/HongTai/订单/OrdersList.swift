//
//  OrdersList.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/11/13.
//  Copyright © 2018 欧张帆. All rights reserved.
//

import UIKit

class OrdersList: NSObject, NSCoding {
    
    var shangpinimage:String
    var shangpinname:String
    var shangpinprice:String
    var shangpinnumber:String
    var shangpintotal:String
    
    required init(shangpinimage:String = "",shangpinname:String = "", shangpinprice:String = "", shangpinnumber: String = "",shangpintotal:String = ""){
        self.shangpinimage = shangpinimage
        self.shangpinname = shangpinname
        self.shangpinprice = shangpinprice
        self.shangpinnumber = shangpinnumber
        self.shangpintotal = shangpintotal
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.shangpinimage = decoder.decodeObject(forKey: "shangpinimage") as! String
        self.shangpinname = decoder.decodeObject(forKey: "shangpinname") as! String
        self.shangpinprice = decoder.decodeObject(forKey: "shangpinprice")as! String
        self.shangpinnumber = decoder.decodeObject(forKey: "shangpinnumber")as! String
        self.shangpintotal = decoder.decodeObject(forKey: "shangpintotal")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(shangpinimage,forKey:"shangpinimage")
        coder.encode(shangpinname,forKey:"shangpinname")
        coder.encode(shangpinprice, forKey: "shangpinprice")
        coder.encode(shangpinnumber, forKey: "shangpinnumber")
        coder.encode(shangpintotal, forKey: "shangpintotal")
    }
}
