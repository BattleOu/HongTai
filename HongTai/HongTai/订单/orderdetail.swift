//
//  orderdetail.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/13.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData
class orderdetail: UITableViewController {
   var i : Int!
    var orders = [orderss]()
    var oorder: orderss?
     var datemodel = Modelorder()
    @IBOutlet weak var orderstates: UILabel!
    @IBOutlet weak var zhuangtaiimg: UIImageView!
    @IBOutlet weak var shouhuoren: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var dingdanid: UILabel!
    @IBOutlet weak var xiadantime: UILabel!
    @IBOutlet weak var goodsimg: UIImageView!
    @IBOutlet weak var goodsname: UILabel!
    @IBOutlet weak var goodsmoney: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var totalgood: UILabel!
    @IBOutlet weak var pay: UIButton!
    @IBOutlet weak var get: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalData()
        datemodel.loadData()
//        pay.layer.cornerRadius=12
//        pay.layer.masksToBounds=true
//        pay.layer.borderColor = UIColor(red: 192/255, green:192/255, blue:192/255, alpha:1).cgColor
//        pay.layer.borderWidth=2
//
//        get.layer.cornerRadius=12
//        get.layer.masksToBounds=true
//        get.layer.borderColor = UIColor(red: 192/255, green:192/255, blue:192/255, alpha:1).cgColor
//        get.layer.borderWidth=2
    orderstates.text = datemodel.listorder[i].orderstate
        if datemodel.listorder[i].orderstate == "待付款"
        {
            zhuangtaiimg.image = UIImage.init(named: "daifukuan01")
             get.isHidden = true
        }
        if datemodel.listorder[i].orderstate == "待收货"
        {
            zhuangtaiimg.image = UIImage.init(named: "yifukuan")
            pay.isHidden = true
        }
        if datemodel.listorder[i].orderstate == "已完成"
        {
            zhuangtaiimg.image = UIImage.init(named: "已完成")
            pay.isHidden = true
            get.isHidden = true
        }
        shouhuoren.text = datemodel.listorder[i].getpeople
        address.text = datemodel.listorder[i].getadress
        phone.text = datemodel.listorder[i].getphone
        dingdanid.text = "订单编号："+datemodel.listorder[i].ordersid
        xiadantime.text = "下单时间："+datemodel.listorder[i].ordertime
        var urlStr = NSURL(string: datemodel.listorder[i].goodimage)
        var request = NSURLRequest(url: urlStr as! URL)
        var imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
        var images: UIImage? = nil
        images = UIImage(data: imgData!)!
        goodsimg.image = images
        goodsname.text = datemodel.listorder[i].goodsname
        goodsmoney.text = "￥" + datemodel.listorder[i].goodprice
        number.text = "数量："+datemodel.listorder[i].goodnumber
        totalgood.text = "¥" + datemodel.listorder[i].goodtotal
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func pay(_ sender: Any) {
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
        fetchRequest.predicate = NSPredicate(format: "ordersid = '\(self.datemodel.listorder[i].ordersid)'")
        // 返回结果在finalResult中
        var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        for c in fetchObject as! [Orders]
        {
          
            c.orderstate = "待收货"
            app.saveContext()
            datemodel.loadData()
            datemodel.listorder[self.i] = Listorder(getadress: c.getadress!, getpeople: c.getpeople!, getphone:c.getphone!, goodimage:  c.goodimage!, goodnumber:  c.goodnumber!, goodprice:  c.goodprice!,goodsname: c.goodsname!,goodtotal: c.goodtotal!,ordersid: c.ordersid!,ordersmoney: c.ordersmoney!,orderstate:"待收货",ordertime: c.ordertime!,username: c.username!)
            datemodel.saveData()
            let alertController = UIAlertController(title: "提示!",
                                                    message: "付款成功", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                action in
                self.performSegue(withIdentifier: "jin", sender: self)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    @IBAction func get(_ sender: Any) {
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
        fetchRequest.predicate = NSPredicate(format: "ordersid = '\(self.datemodel.listorder[i].ordersid)'")
        // 返回结果在finalResult中
        var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        for c in fetchObject as! [Orders]
        {
            
            c.orderstate = "已完成"
            app.saveContext()
            datemodel.loadData()
            datemodel.listorder[self.i] = Listorder(getadress: c.getadress!, getpeople: c.getpeople!, getphone:c.getphone!, goodimage:  c.goodimage!, goodnumber:  c.goodnumber!, goodprice:  c.goodprice!,goodsname: c.goodsname!,goodtotal: c.goodtotal!,ordersid: c.ordersid!,ordersmoney: c.ordersmoney!,orderstate:"已完成",ordertime: c.ordertime!,username: c.username!)
            datemodel.saveData()
            let alertController = UIAlertController(title: "提示!",
                                                    message: "收货成功", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                action in
                self.performSegue(withIdentifier: "jin1", sender: self)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension orderdetail {
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
