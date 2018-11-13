//
//  goodsdetailController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/30.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData
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
    var orderModel = OrdersModel()
    var img:String!
    var name:String!
    var price:String!
    var stock:String!
    var salesnum:String!
    var introduction:String!
    var godstyle:String!
    var carts = [caart]()
    var ccart: caart?
    var orders = [orderss]()
    var oorder: orderss?
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
        xiaoliang.text = "月销量:" + salesnum + "件"
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
        getLocalData()
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
            
            let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
            if(fetchObject!.isEmpty == false)
            {
                for x in 0...carts.count - 1
                {
                    if carts[x].goodsname == goodnam.text && carts[x].userid == dataModel.userliebiao[0].id
                    {
                        
                        let num = carts[x].number
                        let number = Int(shuliang.text!)! + Int(num)!
                        let tottal = String(money! * number)
                        let app = UIApplication.shared.delegate as! AppDelegate
                        func getContexts() -> NSManagedObjectContext{
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            return appDelegate.persistentContainer.viewContext
                        }
                        //获取数据上下文对象
                        let context = getContexts()
                        //声明数据的请求，声明一个实体结构
                        
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
                        //查询条件
                        fetchRequest.predicate = NSPredicate(format: "goodsname = '\(carts[x].goodsname)'")
                        // 返回结果在finalResult中
                        
                        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
                        //            //对返回的数据做处理。
                        //            let fetchObject  = result.finalResult! as! [Cart]
                        var fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
                        if number > Int(carts[x].stock)!
                        {
                            let alertController = UIAlertController(title: "提示!", message: "所加商品大于库存，无法加入购物车", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "确认", style: .default,handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else
                        {
                        for c in fetchObject as! [Cart]
                        {
                            let alertController = UIAlertController(title: "提示!", message: "添加成功", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                                action in
                                 self.performSegue(withIdentifier: "cart", sender: self)
                            })
                            c.total = tottal
                            c.number = String(Int(shuliang.text!)! + Int(num)!)
                            app.saveContext()
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        }
//                        modeldata.cartlist[x] = CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id,total: tottal, number:String(Int(shuliang.text!)! + Int(num)!),username:dataModel.userliebiao[0].name)
//                        modeldata.saveData()
                        return
                        continue
                    }
                }
//                modeldata.cartlist.append(CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id,total: ttotal, number:shuliang.text!,username:dataModel.userliebiao[0].name))
//                modeldata.saveData()
                let alertController = UIAlertController(title: "提示!", message: "添加成功", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                    action in
                    self.performSegue(withIdentifier: "cart", sender: self)
                })
                let user = caart(userid: dataModel.userliebiao[0].id, total: ttotal, stock: stock, salesnum: salesnum, number: shuliang.text!, marketprice: price, introduction: introduction, goodstyle: godstyle, goodsname: name, goodsimg: img,username:dataModel.userliebiao[0].name  )
                
                goodsdetailController.insertData(contactInfo: user)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else
            {
//                modeldata.cartlist.append(CartList(goodsimg:img, goodstyle: godstyle, goodsname: name, introduction: introduction,marketprice: price,salesnum: salesnum,stock: stock ,userid: dataModel.userliebiao[0].id,total: ttotal, number:shuliang.text!,username:dataModel.userliebiao[0].name))
//                modeldata.saveData()
                let alertController = UIAlertController(title: "提示!", message: "添加成功", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                    action in
                    self.performSegue(withIdentifier: "cart", sender: self)
                })
                let user = caart(userid: dataModel.userliebiao[0].id, total: ttotal, stock: stock, salesnum: salesnum, number: shuliang.text!, marketprice: price, introduction: introduction, goodstyle: godstyle, goodsname: name, goodsimg: img,username:dataModel.userliebiao[0].name )
                
                goodsdetailController.insertData(contactInfo: user)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            
        }
    }
    
    @IBAction func buys(_ sender: Any) {
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
         
            orderModel.loadData()
            orderModel.orderslist.append(OrdersList(
                shangpinimage: img,
            shangpinname: goodnam.text!,
            shangpinprice: goodprice.text!,
            shangpinnumber: String(num!) ,
            shangpintotal: ttotal
            ))
            orderModel.saveData()
            print("购买加进")
              let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OrderNavigation()))) as! OrderNavigation
              self.present(controller, animated: true)
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
extension goodsdetailController {
    
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

extension goodsdetailController {
    
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
    
    class func insertData(contactInfo: caart) {
        
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: managedObectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        //        步骤三：保存数值
        
        user.setValue(contactInfo.goodsimg, forKey: "goodsimg")
        user.setValue(contactInfo.goodsname, forKey: "goodsname")
        user.setValue(contactInfo.goodstyle, forKey: "goodstyle")
        user.setValue(contactInfo.introduction, forKey: "introduction")
        user.setValue(contactInfo.marketprice, forKey: "marketprice")
        user.setValue(contactInfo.number, forKey: "number")
        user.setValue(contactInfo.salesnum, forKey: "salesnum")
        user.setValue(contactInfo.stock, forKey: "stock")
        user.setValue(contactInfo.total, forKey: "total")
        user.setValue(contactInfo.userid, forKey: "userid")
        user.setValue(contactInfo.username, forKey: "username")
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
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
