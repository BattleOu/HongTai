//
//  onsignee.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/9.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData
class Consignee: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var consigneename: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var consigneeadress: UITextField!
    @IBOutlet weak var ordersmoney: UILabel!
    var dataModel = DataModel()
    var modeldata = CartModel()
    var orders = [orderss]()
    var orrder: orderss?
    var carts = [caart]()
    var ccart: caart?
    var sum:String! = "0"
    var total: String!
    var number: String!
    var marketprice:String!
    var goodsname: String!
    var goodsimg: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.loadData()
        getLocalData()
        username.text = dataModel.userliebiao[0].name
        
        if goodsname != nil
        {
            ordersmoney.text = total
        }
        else
        {
            if carts.isEmpty == false
            {
                for x in 0...carts.count - 1
                {
                    if carts[x].username == username.text
                    {
                        sum = String(Int(sum)! + Int(carts[x].total)!)
                        ordersmoney.text = "￥" + sum
                    }
                    continue
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func orders(_ sender: Any) {
    }
    @IBAction func back(_ sender: Any) {
          self.performSegue(withIdentifier: "back", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension Consignee {
    
    fileprivate func getLocalData() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                carts.removeAll()
                for result in results {
                    guard let cartss = translateData(from: result) else { return }
                    carts.append(cartss)
                }
            }
            
        } catch  {
            fatalError("获取失败")
        }
        
    }
    
    
    fileprivate func translateData(from: NSManagedObject) -> (caart?) {
        
        if let img = from.value(forKey: "goodsimg") as? String,let goodsname = from.value(forKey: "goodsname") as? String,let style = from.value(forKey: "goodstyle") as? String,let introduction = from.value(forKey: "introduction") as? String, let marketprice = from.value(forKey: "marketprice") as? String, let number = from.value(forKey: "number") as? String, let salesnum = from.value(forKey: "salesnum") as? String, let stock = from.value(forKey: "stock") as? String, let total = from.value(forKey: "total") as? String, let userid = from.value(forKey: "userid") as? String, let username = from.value(forKey: "username") as? String{
            let user = caart(userid: userid, total: total, stock: stock, salesnum: salesnum, number: number, marketprice: marketprice, introduction: introduction, goodstyle: style, goodsname: goodsname, goodsimg: img,username:username)
            
            return user
        }
        return nil
    }
}

extension Consignee {
    
    fileprivate func getLocalData1() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                orders.removeAll()
                for result in results {
                    guard let ordder = translateData1(from: result) else { return }
                    orders.append(ordder)
                }
            }
            
        } catch  {
            fatalError("获取失败")
        }
        
    }
    
    
    fileprivate func translateData1(from: NSManagedObject) -> (orderss?) {
        
        if let getadress = from.value(forKey: "getadress") as? String,let getpeople = from.value(forKey: "getpeople") as? String,let getphone = from.value(forKey: "getphone") as? String,let goodimage = from.value(forKey: "goodimage") as? String, let goodnumber = from.value(forKey: "goodnumber") as? String, let goodprice = from.value(forKey: "goodprice") as? String, let goodsname = from.value(forKey: "goodsname") as? String, let goodtotal = from.value(forKey: "goodtotal") as? String, let ordersid = from.value(forKey: "ordersid") as? String, let ordersmoney = from.value(forKey: "ordersmoney") as? String, let orderstate = from.value(forKey: "orderstate") as? String, let ordertime = from.value(forKey: "ordertime") as? String, let username = from.value(forKey: "username") as? String{
            let orrdder = orderss(getadress:getadress ,getpeople:getpeople,getphone:getphone,goodimage:goodimage,goodnumber:goodnumber,goodprice:goodprice,goodsname:goodsname,goodtotal:goodtotal,ordersid:ordersid,ordersmoney:ordersmoney,orderstate:orderstate,ordertime:ordertime,username:username )
            
            return orrdder
        }
        return nil
    }
}
