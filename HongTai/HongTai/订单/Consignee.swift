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
     var datemodel = Modelorder()
      var orderModel = OrdersModel()
    var orders = [orderss]()
    var oorder: orderss?
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
        orderModel.loadData()
        if orderModel.orderslist.isEmpty == false
        {
            ordersmoney.text = orderModel.orderslist[0].shangpintotal
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
        getLocalData1()
     if(consigneename.text != "" && phone.text != "" && consigneeadress.text != "")
     {
        let expression = "^((1\\d)|(14[5|7])|(15([0-3]|[5-9]))|(18[^14]))\\d{8}$"//"|"表示什么就不用说了吧，[5|7]表示满足其中任意一个即匹配，数量唯一，"[0-3]"则表示满足0到之间的数字即匹配，数量唯一，[^14]表示匹配除1和4以外的任意字符，这里包括了字母，所以建议弹出键盘类型为数字键盘
        
        let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        
        let numberOfMatches = regex.numberOfMatches(in: phone.text!, options:.reportProgress, range: NSMakeRange(0, (phone.text! as NSString).length))//获取匹配的个数
        let expression1 = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let regex1 = try! NSRegularExpression(pattern: expression1, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        
        let numberOfMatches1 = regex1.numberOfMatches(in: consigneeadress.text!, options:.reportProgress, range: NSMakeRange(0, (consigneeadress.text! as NSString).length))//获取匹配的个数
        let expression2 = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let regex2 = try! NSRegularExpression(pattern: expression2, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        
        let numberOfMatches2 = regex2.numberOfMatches(in: consigneename.text!, options:.reportProgress, range: NSMakeRange(0, (consigneename.text! as NSString).length))//获取匹配的个数
        if(numberOfMatches2 == 0)
        {
            let alertController = UIAlertController(title: "提示!",
                                                    message: "收货人名称有误！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
       else if numberOfMatches == 0{
            let alertController = UIAlertController(title: "提示!",
                                                    message: "请输入正确的电话号码！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
            
        }//如果匹配，则登录按钮生效，否则反之
        else if(numberOfMatches1 == 0)
        {
            let alertController = UIAlertController(title: "提示!",
                                                    message: "请输入正确的送货地址！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = NSTimeZone.local
        timeFormatter.dateFormat = "yyyyMMddHHmmss"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        let date1 = NSDate()
        let timeFormatter1 = DateFormatter()
        timeFormatter1.timeZone = NSTimeZone.local
        timeFormatter1.dateFormat = "yyyy年MM月dd日 HH:mm"
        let strNowTime1 = timeFormatter1.string(from: date1 as Date) as String
        let user1 = orderss(getadress: consigneeadress.text!, getpeople: consigneename.text!, getphone: phone.text!, goodimage: orderModel.orderslist[0].shangpinimage, goodnumber: orderModel.orderslist[0].shangpinnumber , goodprice: orderModel.orderslist[0].shangpinprice,goodsname:orderModel.orderslist[0].shangpinname,goodtotal:orderModel.orderslist[0].shangpintotal,ordersid:strNowTime,ordersmoney:orderModel.orderslist[0].shangpintotal,orderstate:"待付款",ordertime:strNowTime1,username:dataModel.userliebiao[0].name)
        Consignee.insertData1(contactInfo: user1)
        datemodel.loadData()
        datemodel.listorder.append(Listorder(getadress: consigneeadress.text!, getpeople: consigneename.text!, getphone: phone.text!, goodimage: orderModel.orderslist[0].shangpinimage, goodnumber: orderModel.orderslist[0].shangpinnumber , goodprice: orderModel.orderslist[0].shangpinprice,goodsname:orderModel.orderslist[0].shangpinname,goodtotal:orderModel.orderslist[0].shangpintotal,ordersid:strNowTime,ordersmoney:orderModel.orderslist[0].shangpintotal,orderstate:"待付款",ordertime:strNowTime1,username:dataModel.userliebiao[0].name))
        datemodel.saveData()
        let alertController = UIAlertController(title: "提示!",
                                                message: "下单成功", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default,handler: {
            action in
            self.performSegue(withIdentifier: "xiadanle", sender: self)
            
        })
        
//        self.getLocalData1()
//        let app = UIApplication.shared.delegate as! AppDelegate
//        func getContexts() -> NSManagedObjectContext{
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//            return appDelegate.persistentContainer.viewContext
//        }
//        //获取数据上下文对象
//        let context = getContexts()
//        //声明数据的请求，声明一个实体结构
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
//        //查询条件
//        fetchRequest.predicate = NSPredicate(format: "goodsname = '\(self.orderModel.orderslist[0].shangpinname)'")
//        // 返回结果在finalResult中
//
//        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
//        //            //对返回的数据做处理。
//        //            let fetchObject  = result.finalResult! as! [Cart]
//        var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
//        for c in fetchObject as! [Cart]
//        {
//            context.delete(c)
//            app.saveContext()
//        }
        
        self.orderModel.loadData()
        self.orderModel.orderslist.removeAll()
        self.orderModel.saveData()
        print("maile meile")
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
        else
     {
        let alertController = UIAlertController(title: "提示!",
                                                message: "请完整填写信息！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    }
    @IBAction func back(_ sender: Any) {
        orderModel.loadData()
        orderModel.orderslist.removeAll()
        orderModel.saveData()
        print("没来没了")
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
                    guard let ordersss = translateData1(from: result) else { return }
                    orders.append(ordersss)
                }
            }
            
        } catch  {
            fatalError("获取失败")
        }
        
    }
    
    class func insertData1(contactInfo: orderss) {
        
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Orders", in: managedObectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        //        步骤三：保存数值
        
        user.setValue(contactInfo.getadress, forKey: "getadress")
        user.setValue(contactInfo.getpeople, forKey: "getpeople")
        user.setValue(contactInfo.getphone, forKey: "getphone")
        user.setValue(contactInfo.goodimage, forKey: "goodimage")
        user.setValue(contactInfo.goodnumber, forKey: "goodnumber")
        user.setValue(contactInfo.goodprice, forKey: "goodprice")
        user.setValue(contactInfo.goodsname, forKey: "goodsname")
        user.setValue(contactInfo.goodtotal, forKey: "goodtotal")
        user.setValue(contactInfo.ordersid, forKey: "ordersid")
        user.setValue(contactInfo.ordersmoney, forKey: "ordersmoney")
        user.setValue(contactInfo.orderstate, forKey: "orderstate")
        user.setValue(contactInfo.ordertime, forKey: "ordertime")
        user.setValue(contactInfo.username, forKey: "username")
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        
    }
    fileprivate func translateData1(from: NSManagedObject) -> (orderss?) {
        
        if let name = from.value(forKey: "username") as? String,
            let id = from.value(forKey: "ordersid") as? String,
            let image = from.value(forKey: "goodimage") as? String,
            let goodname = from.value(forKey: "goodsname") as? String,
            let price = from.value(forKey: "goodprice") as? String,
            let number = from.value(forKey: "goodnumber") as? String,
            let total = from.value(forKey: "goodtotal") as? String,
            let people = from.value(forKey: "getpeople") as? String,
            let adress = from.value(forKey: "getadress") as? String,
            let phone = from.value(forKey: "getphone") as? String,
            let money = from.value(forKey: "ordersmoney") as? String,
            let state = from.value(forKey: "orderstate") as? String,
            let time = from.value(forKey: "ordertime") as? String{
            let user = orderss(getadress: adress, getpeople: people, getphone: phone, goodimage: image, goodnumber: number, goodprice: price, goodsname: goodname, goodtotal: total, ordersid: id, ordersmoney:money, orderstate: state, ordertime:time, username: name)
            
            return user
        }
        return nil
    }
   
}
