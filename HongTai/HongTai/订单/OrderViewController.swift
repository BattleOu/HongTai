//
//  OrderViewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/13.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData
class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ordertableview: UITableView!
    var orders = [orderss]()
    var oorder: orderss?
    var dataModel = DataModel()
    var datemodel = Modelorder()
    override func viewDidLoad() {
        super.viewDidLoad()
       ordertableview.dataSource = self
        ordertableview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getLocalData()
        datemodel.loadData()
        if datemodel.listorder.count > 0
        {
            return datemodel.listorder.count
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
        datemodel.loadData()
        dataModel.loadData()
        let app = UIApplication.shared.delegate as! AppDelegate
        func getContext() -> NSManagedObjectContext{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            return appDelegate.persistentContainer.viewContext
        }
        //获取数据上下文对象
        let context = getContext()
        //声明数据的请求，声明一个实体结构
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
        //查询条件
        fetchRequest.predicate = NSPredicate(format: "username = '\(datemodel.listorder[0].username)'")
        // 返回结果在finalResult中
        
        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
        //            //对返回的数据做处理。
        //            let fetchObject  = result.finalResult! as! [Cart]
        let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        if(fetchObject!.isEmpty == false)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderscell", for: indexPath)
            if let myCell = cell as? ordercell
            {
                if datemodel.listorder[indexPath.row].username == dataModel.userliebiao[0].name
                {
                    myCell.goodsname.text = datemodel.listorder[indexPath.row].goodsname
                    var urlStr = NSURL(string: datemodel.listorder[indexPath.row].goodimage)
                    var request = NSURLRequest(url: urlStr as! URL)
                    var imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
                    var images: UIImage? = nil
                    images = UIImage(data: imgData!)!
                    myCell.goodimg.image = images
                    myCell.goodnum.text = datemodel.listorder[indexPath.row].goodnumber
                    myCell.ordermoney.text = "￥" + datemodel.listorder[indexPath.row].goodtotal
                    myCell.shouhuoren.text = datemodel.listorder[indexPath.row].getpeople
//                    myCell.goodprice.text = orders[indexPath.row].goodprice
                    return myCell
                }
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderscell", for: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除") {
            action , index in
            self.datemodel.loadData()
            self.dataModel.loadData()
            if(self.datemodel.listorder[indexPath.row].orderstate == "已完成" || self.datemodel.listorder[indexPath.row].orderstate == "待付款")
                {
                        let app = UIApplication.shared.delegate as! AppDelegate
                        func getContext() -> NSManagedObjectContext{
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            return appDelegate.persistentContainer.viewContext
                        }
                        //获取数据上下文对象
                        let context = getContext()
                        //声明数据的请求，声明一个实体结构
                        
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
                        //查询条件
                        fetchRequest.predicate = NSPredicate(format: "goodsname = '\(self.datemodel.listorder[indexPath.row].goodsname)' and username = '\(self.dataModel.userliebiao[0].name)'")
                        // 返回结果在finalResult中
                        
                        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
                        //            //对返回的数据做处理。
                        //            let fetchObject  = result.finalResult! as! [Cart]
                        var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
                        for c in fetchObject as! [Orders]
                        {
                            context.delete(c)
                            app.saveContext()
                        }
                    
                    self.datemodel.loadData()
                    self.datemodel.listorder.remove(at: indexPath.row)
                    self.datemodel.saveData()
                    

                        self.ordertableview.reloadData()

                }
            else
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "订单未完成,无法删除！", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            }
            }
                delete.backgroundColor = UIColor.red
        
        
       
     
                return [delete]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ordersssss"{
            if let indexPath = self.ordertableview.indexPathForSelectedRow{
                let noteview = segue.destination as! orderdetail
                noteview.i = indexPath.row
            }
        }
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


extension OrderViewController {
    fileprivate func getLocalData() {
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
                    guard let ordersss = translateData(from: result) else { return }
                    orders.append(ordersss)
                }
            }
            
        } catch  {
            fatalError("获取失败")
        }
        
    }
    
    fileprivate func translateData(from: NSManagedObject) -> (orderss?) {
        
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
