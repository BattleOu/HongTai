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
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalData()
    orderstates.text = orders[i].orderstate
        if orders[i].orderstate == "待付款"
        {
            zhuangtaiimg.image = UIImage.init(named: "daifukuan01")
        }
        if orders[i].orderstate == "已付款,待收货"
        {
            zhuangtaiimg.image = UIImage.init(named: "yifukuan")
        }
        shouhuoren.text = orders[i].getpeople
        address.text = orders[i].getadress
        phone.text = orders[i].getphone
        dingdanid.text = "订单编号："+orders[i].ordersid
        xiadantime.text = "下单时间："+orders[i].ordertime
        var urlStr = NSURL(string: orders[i].goodimage)
        var request = NSURLRequest(url: urlStr as! URL)
        var imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
        var images: UIImage? = nil
        images = UIImage(data: imgData!)!
        goodsimg.image = images
        goodsname.text = orders[i].goodsname
        goodsmoney.text = "￥" + orders[i].goodprice
        number.text = "数量："+orders[i].goodnumber
        totalgood.text = "¥" + orders[i].goodtotal
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
