//
//  CartviewController.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/11/8.
//  Copyright © 2018 欧张帆. All rights reserved.
//

import UIKit
import CoreData
class CartviewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var modeldata = CartModel()
    var dataModel = DataModel()
    var orderModel = OrdersModel()
    var carts = [caart]()
    var ccart: caart?
    var orders = [orderss]()
    var oorder: orderss?
    @IBOutlet weak var goubuy: UIButton!
    @IBOutlet weak var Tabelview: UITableView!
    @IBOutlet weak var clear: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.loadData()
        if(dataModel.userliebiao.isEmpty)
        {
            self.performSegue(withIdentifier: "kong", sender: self)
        }
        else
        {
            let app = UIApplication.shared.delegate as! AppDelegate
            func getContext() -> NSManagedObjectContext{
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                return appDelegate.persistentContainer.viewContext
            }
            //获取数据上下文对象
            let context = getContext()
            //声明数据的请求，声明一个实体结构
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            //查询条件
            fetchRequest.predicate = NSPredicate(format: "userid = '\(dataModel.userliebiao[0].id)'")
            // 返回结果在finalResult中
            
            //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
            //            //对返回的数据做处理。
            //            let fetchObject  = result.finalResult! as! [Cart]
            let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
            if(fetchObject!.isEmpty)
            {
                goubuy.isHidden = true
                clear.isHidden = true
            }
            Tabelview.delegate = self
            Tabelview.dataSource = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modeldata.loadData()
        if modeldata.cartlist.count > 0
        {
            return modeldata.cartlist.count
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getLocalData()
        modeldata.loadData()
        let app = UIApplication.shared.delegate as! AppDelegate
        func getContext() -> NSManagedObjectContext{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            return appDelegate.persistentContainer.viewContext
        }
        //获取数据上下文对象
        let context = getContext()
        //声明数据的请求，声明一个实体结构
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        //查询条件
        fetchRequest.predicate = NSPredicate(format: "userid = '\(dataModel.userliebiao[0].id)'")
        // 返回结果在finalResult中
        
        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
        //            //对返回的数据做处理。
        //            let fetchObject  = result.finalResult! as! [Cart]
        let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        if(fetchObject!.isEmpty == false)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cartt", for: indexPath)
            if let myCell = cell as? CartCell
            {
                if modeldata.cartlist[indexPath.row].userid == dataModel.userliebiao[0].id
                {
                    myCell.godsname.text = modeldata.cartlist[indexPath.row].goodsname
                    myCell.godsprice.text = "￥" + modeldata.cartlist[indexPath.row].marketprice
                    var urlStr = NSURL(string: modeldata.cartlist[indexPath.row].goodsimg)
                    var request = NSURLRequest(url: urlStr as! URL)
                    var imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
                    var images: UIImage? = nil
                    images = UIImage(data: imgData!)!
                    myCell.imagesgood.image = images
                    myCell.godsnum.text = modeldata.cartlist[indexPath.row].number
                    myCell.godstotal.text = "￥" + modeldata.cartlist[indexPath.row].total
                    return myCell
                }
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cartt", for: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除") {
            action , index in
            //将对应条目的数据删除
           self.modeldata.loadData()
            self.getLocalData()
            let app = UIApplication.shared.delegate as! AppDelegate
            func getContext() -> NSManagedObjectContext{
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                return appDelegate.persistentContainer.viewContext
            }
            //获取数据上下文对象
            let context = getContext()
            //声明数据的请求，声明一个实体结构
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            //查询条件
            fetchRequest.predicate = NSPredicate(format: "goodsname = '\(self.modeldata.cartlist[indexPath.row].goodsname)' and username = '\(self.dataModel.userliebiao[0].name)'")
            // 返回结果在finalResult中
            
            //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
            //            //对返回的数据做处理。
            //            let fetchObject  = result.finalResult! as! [Cart]
            var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
            for c in fetchObject as! [Cart]
            {
                context.delete(c)
                app.saveContext()
            }
            self.modeldata.loadData()
            self.modeldata.cartlist.remove(at: indexPath.row)
            self.modeldata.saveData()
            if (self.modeldata.cartlist.isEmpty)
            {
                self.goubuy.isHidden = true
                self.clear.isHidden = true
            }
            self.Tabelview.reloadData()
        }
        delete.backgroundColor = UIColor.red
        
        let buy = UITableViewRowAction(style: .normal, title: "购买") {
             action , index in
//            let money = Int(price)
//            let num = Int(shuliang.text!)
//            let ttotal =  String(money! * num!)
            self.getLocalData()
            self.modeldata.loadData()
            self.orderModel.loadData()
            self.orderModel.orderslist.append(OrdersList(
                shangpinimage: self.modeldata.cartlist[indexPath.row].goodsimg,
                shangpinname: self.modeldata.cartlist[indexPath.row].goodsname,
                shangpinprice: self.modeldata.cartlist[indexPath.row].marketprice,
                shangpinnumber: self.modeldata.cartlist[indexPath.row].number,
                shangpintotal: self.modeldata.cartlist[indexPath.row].total
            ))
            self.orderModel.saveData()
            print("购买加进")
             let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OrderNavigation2()))) as! OrderNavigation2
            self.present(controller, animated: true)
        }
        buy.backgroundColor = UIColor.orange
        return [delete,buy]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modeldata.loadData()
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: goodsdetailController()))) as! goodsdetailController
        controller.img = modeldata.cartlist[indexPath.row].goodsimg
        controller.introduction = modeldata.cartlist[indexPath.row].introduction
        controller.name = modeldata.cartlist[indexPath.row].goodsname
        controller.price =  modeldata.cartlist[indexPath.row].marketprice
        controller.salesnum =  modeldata.cartlist[indexPath.row].salesnum
        controller.stock =  modeldata.cartlist[indexPath.row].stock
        controller.godstyle =  modeldata.cartlist[indexPath.row].goodstyle
        self.present(controller, animated: true)
    }
    @IBAction func jian(_ sender: Any) {
        //        modeldata.loadData()
        //        for x in 0...modeldata.cartlist.count - 1
        //        {
        //            if cart.godsname.text == modeldata.cartlist[x].goodsname
        //            {
        //               let temp = Int(cart.godsnum.text!)
        //                let temp2 = modeldata.cartlist[x].stock
        //                if temp == nil
        //                {
        //                    return
        //                }
        //                else
        //                {
        //                    if temp == 1
        //                    {
        //                        return
        //                    }
        //                    else
        //                    {
        //                        let temp1 = String(temp! - 1)
        //                        cart.godsnum.text = temp1
        //                        if temp1 > temp2
        //                        {
        //                            let alertController = UIAlertController(title: "提示!",
        //                                                                    message: "数量大于库存", preferredStyle: .alert)
        //                            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
        //                            alertController.addAction(okAction)
        //                            self.present(alertController, animated: true, completion: nil)
        //                        }
        //                        else
        //                        {
        //                            let temp1 = String(temp! - 1)
        //                            cart.godsnum.text = temp1
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }
    
    @IBAction func jia(_ sender: Any) {
         self.performSegue(withIdentifier: "dindan", sender: self)
    }
    
    @IBAction func clear(_ sender: Any) {
//        func getContext() -> NSManagedObjectContext{
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            return appDelegate.persistentContainer.viewContext
//        }
//        //获取委托
//        let app = UIApplication.shared.delegate as! AppDelegate
//        //获取数据上下文对象
//
//        let context = getContext()
//
//        //声明数据的请求，声明一个实体结构
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
//
//        // 异步请求由两部分组成：普通的request和completion handler
//
////         返回结果在finalResult中
//
//        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result:NSAsynchronousFetchResult) in
//            //对返回的数据做处理。
//
//            let fetchObject = result.finalResult! as! [Orders]
//
//            for c in fetchObject{
//                //所有删除信息
//
//                context.delete(c)
//                print("完美删除！")
//
//            }
//
//            app.saveContext()
//
//        }
//
//
//
//        // 执行异步请求调用execute
//
//        do {
//
//            try context.execute(asyncFetchRequest)
//
//        } catch  {
//
//            print("error")
//
//        }
        getLocalData()
        let app = UIApplication.shared.delegate as! AppDelegate
        func getContext() -> NSManagedObjectContext{

            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            return appDelegate.persistentContainer.viewContext
        }
        //获取数据上下文对象
        let context = getContext()
        //声明数据的请求，声明一个实体结构

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        //查询条件
        fetchRequest.predicate = NSPredicate(format: "userid = '\(dataModel.userliebiao[0].id)'")
        // 返回结果在finalResult中

        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
        //            //对返回的数据做处理。
        //            let fetchObject  = result.finalResult! as! [Cart]
        var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        for c in fetchObject as! [Cart]
        {
            context.delete(c)
            app.saveContext()
        }
        modeldata.loadData()
        modeldata.cartlist.removeAll()
        modeldata.saveData()
        Tabelview.reloadData()
    }
    @IBAction func buyes(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OrderNavigation3()))) as! OrderNavigation3
        self.present(controller, animated: true)
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

extension CartviewController {
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
        
        user.setValue(contactInfo.username, forKey: "username")
        user.setValue(contactInfo.ordersid, forKey: "ordersid")
        user.setValue(contactInfo.goodimage, forKey: "goodimage")
        user.setValue(contactInfo.goodsname, forKey: "goodsname")
        user.setValue(contactInfo.goodprice, forKey: "goodprice")
        user.setValue(contactInfo.goodnumber, forKey: "goodnumber")
        user.setValue(contactInfo.goodtotal, forKey: "goodtotal")
        user.setValue(contactInfo.getpeople, forKey: "getpeople")
        user.setValue(contactInfo.getadress, forKey: "getadress")
        user.setValue(contactInfo.getphone, forKey: "getphone")
        user.setValue(contactInfo.ordersmoney, forKey: "ordersmoney")
        user.setValue(contactInfo.orderstate, forKey: "orderstate")
        user.setValue(contactInfo.ordertime, forKey: "ordertime")
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

extension CartviewController {
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
