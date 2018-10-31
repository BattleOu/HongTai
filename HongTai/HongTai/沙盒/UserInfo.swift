//
//  UserInfo.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/31.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit


class UserInfo: NSObject , NSCoding{
    var name :String
    var password :String
    var id :String
    var image: Data
    var realname :String
    var update : Date
    
    
    //构造方法
    required init(name:String="",password:String="",id:String="",image:Data,realname:String="",update:Date){
        self.name = name
        self.password = password
        self.id = id
        self.image = image
        self.realname = realname
        self.update = update
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.password = decoder.decodeObject(forKey: "password") as! String
        self.id = decoder.decodeObject(forKey: "id") as! String
        self.image = decoder.decodeObject(forKey: "image") as! Data
        self.realname = decoder.decodeObject(forKey: "realname") as! String
        self.update = decoder.decodeObject(forKey: "update") as! Date
        
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(name,forKey:"name")
        coder.encode(password,forKey:"password")
        coder.encode(id,forKey:"id")
        coder.encode(image,forKey:"image")
        coder.encode(realname,forKey:"realname")
        coder.encode(update,forKey:"update")
    }
}
