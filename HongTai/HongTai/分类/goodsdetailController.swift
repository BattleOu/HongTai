//
//  goodsdetailController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/30.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class goodsdetailController: UITableViewController {

    @IBOutlet weak var goodimg: UIImageView!
    
    @IBOutlet weak var goodnam: UILabel!
    @IBOutlet weak var goodprice: UILabel!
    @IBOutlet weak var kucun: UILabel!
    @IBOutlet weak var xiaoliang: UILabel!
    @IBOutlet weak var jieshao: UITextView!
    @IBOutlet weak var shuliang: UITextField!
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var cart: UIButton!
     var dataModel = DataModel()
    var modeldata = CartModel()
    var img:String!
    var name:String!
    var price:String!
    var stock:String!
    var salesnum:String!
    var introduction:String!
    var godstyle:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlStr = NSURL(string: img)
        var request = NSURLRequest(url: urlStr as! URL)
        var imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
        var images: UIImage? = nil
        images = UIImage(data: imgData!)!
        goodimg.image = images
        goodnam.text = name
        goodprice.text = "￥" + price
        kucun.text = "库存" + stock + "件"
        xiaoliang.text = "销量:" + salesnum + "件"
        jieshao.text = introduction
        print(stock)
        shuliang.addTarget(self, action:#selector(clearPasswordTextFieldAndRememberPwd(_:)), for: .editingChanged)
//        NotificationCenter.defaultCenter.addObserver(self, selector: #selector(loadView().textChanges), name: UITextFieldTextDidChangeNotification, object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
   @objc func clearPasswordTextFieldAndRememberPwd(_ textField: UITextField) {
                let temp = Int(shuliang.text!)
                let temp2 = Int(stock)
                if temp == 0
                {
                    shuliang.text = "1"
                    buy.isEnabled = true
                    cart.isEnabled = true
                    buy.backgroundColor = UIColor.orange
                    cart.backgroundColor = UIColor.orange
                    return
                }
                if temp == nil
                {
                    buy.isEnabled = false
                    cart.isEnabled = false
                    buy.backgroundColor = UIColor.gray
                    cart.backgroundColor = UIColor.gray
                    return
                }
                if temp! > temp2!
                {
                    buy.isEnabled = false
                    cart.isEnabled = false
                    buy.backgroundColor = UIColor.gray
                    cart.backgroundColor = UIColor.gray
                    return
                }
                else
                {
                    buy.isEnabled = true
                    cart.isEnabled = true
                    buy.backgroundColor = UIColor.orange
                    cart.backgroundColor = UIColor.orange
                }
                if temp! < 1
                {
                    buy.isEnabled = false
                    cart.isEnabled = false
                    buy.backgroundColor = UIColor.gray
                    cart.backgroundColor = UIColor.gray
                }
                else
                {
                    buy.isEnabled = true
                    cart.isEnabled = true
                    buy.backgroundColor = UIColor.orange
                    cart.backgroundColor = UIColor.orange
                }
        
    }
//    func textChanges(){
//        let temp = Int(shuliang.text!)
//        let temp2 = Int(stock)
//        if temp! >= temp2!
//        {
//            buy.isEnabled = true
//            cart.isEnabled = true
//            buy.backgroundColor = UIColor.gray
//            cart.backgroundColor = UIColor.gray
//        }
//        else
//        {
//            buy.isEnabled = false
//            cart.isEnabled = false
//            buy.backgroundColor = UIColor.orange
//            cart.backgroundColor = UIColor.orange
//        }
//        if temp! <= 1
//        {
//            buy.isEnabled = true
//            cart.isEnabled = true
//            buy.backgroundColor = UIColor.gray
//            cart.backgroundColor = UIColor.gray
//        }
//        else
//        {
//            buy.isEnabled = false
//            cart.isEnabled = false
//            buy.backgroundColor = UIColor.orange
//            cart.backgroundColor = UIColor.orange
//        }
//
//    }
    
    @IBAction func zengjia(_ sender: Any) {
        let temp = Int(shuliang.text!)
        let temp2 = Int(stock)
        if temp == nil
        {
            shuliang.text = "1"
            buy.isEnabled = true
            cart.isEnabled = true
            buy.backgroundColor = UIColor.orange
            cart.backgroundColor = UIColor.orange
        }
        else
        {
        let temp1 = String(temp! + 1)
        shuliang.text = temp1
        if temp! >= temp2!
        {
            buy.isEnabled = false
            cart.isEnabled = false
            buy.backgroundColor = UIColor.gray
            cart.backgroundColor = UIColor.gray
        }
        else
        {
            buy.isEnabled = true
            cart.isEnabled = true
            buy.backgroundColor = UIColor.orange
            cart.backgroundColor = UIColor.orange
        }
        }
    }
    // MARK: - Table view data source

    @IBAction func jianshao(_ sender: Any) {
//        let temp:Int
//        shuliang.text = String(temp)
        let temp = Int(shuliang.text!)
        let temp2 = Int(stock)
        
        if temp == nil
        {
            return
        }
        else
        {
            if temp == 1
            {
                return
            }
            else
            {
                let temp1 = String(temp! - 1)
                shuliang.text = temp1
                if temp1 > stock
                {
                    buy.isEnabled = false
                    cart.isEnabled = false
                    buy.backgroundColor = UIColor.gray
                    cart.backgroundColor = UIColor.gray
                }
                else
                {
                    buy.isEnabled = true
                    cart.isEnabled = true
                    buy.backgroundColor = UIColor.orange
                    cart.backgroundColor = UIColor.orange
                }
            }
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
         self.performSegue(withIdentifier: "back", sender: self)
    }
    
    
    @IBAction func joincart(_ sender: Any) {
        dataModel.loadData()
        if(dataModel.userliebiao.isEmpty)
        {
            self.performSegue(withIdentifier: "kong", sender: self)
        }
        else
        {
            let money = Int(price)
            let num = Int(shuliang.text!)
            let ttotal =  String(money! * num!)
                modeldata.loadData()
            if(modeldata.cartlist.isEmpty == false)
            {
            for x in 0...modeldata.cartlist.count - 1
            {
                if modeldata.cartlist[x].goodsname == goodnam.text && modeldata.cartlist[x].userid == dataModel.userliebiao[0].id
                {
                    let num = modeldata.cartlist[x].number
                    let number = Int(shuliang.text!)! + Int(num)!
                    let tottal = String(money! * number)
                    modeldata.cartlist[x] = CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id,total: tottal, number:String(Int(shuliang.text!)! + Int(num)!))
                    modeldata.saveData()
                    return 
                     continue
                }
            }
                modeldata.cartlist.append(CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id,total: ttotal, number:shuliang.text!))
                modeldata.saveData()
            }
            else
            {
                modeldata.cartlist.append(CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id,total: ttotal, number:shuliang.text!))
                modeldata.saveData()
            }
            
//            for x in 0...modeldata.userList.count - 1
//            {
//                if img == modeldata.userList[x].goodsimg
//                {
//                    modeldata.loadData()
//                    modeldata.userList[x] = CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id, total: money! * num!, number:shuliang.text!)
//                }
//            }
            self.performSegue(withIdentifier: "cart", sender: self)
            
        }
    }
    
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
