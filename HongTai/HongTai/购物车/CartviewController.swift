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
    var carts = [caart]()
    var ccart: caart?
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
        let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        print(fetchObject!.count)
        if fetchObject!.count > 0
        {
            return fetchObject!.count
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
        //            //对返回的数据做处理。
        //            let fetchObject  = result.finalResult! as! [Cart]
        let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
        if(fetchObject!.isEmpty == false)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cartt", for: indexPath)
            if let myCell = cell as? CartCell
            {
                dataModel.loadData()
                print(modeldata.cartlist[indexPath.row].userid)
                print(dataModel.userliebiao[0].id)
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
            if let myCell = cell as? CartCell
            {
                myCell.godsname.text = "购物车是空的"
                myCell.godsname.textColor = UIColor.red
                myCell.godsname.font = UIFont.systemFont(ofSize: 20)
                myCell.godsnum.isHidden = true
                myCell.godsname.adjustsFontSizeToFitWidth = true  //当文字超出文本框宽度时，自动调整文字大小
                myCell.godsname.minimumScaleFactor = 14  //最小可缩小的字号
                myCell.godsprice.isHidden = true
                myCell.godstotal.isHidden = true
                myCell.imagesgood.isHidden = true
                goubuy.isHidden = true
                clear.isHidden = true
                Tabelview.separatorStyle = UITableViewCell.SeparatorStyle.none
                return myCell
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除") {
            action , index in
            //将对应条目的数据删除
            self.modeldata.loadData()
            self.modeldata.cartlist.remove(at: indexPath.row)
            self.modeldata.saveData()
            
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
            fetchRequest.predicate = NSPredicate(format: "goodsname = '\(self.carts[indexPath.row].goodsname)'")
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
            self.Tabelview.reloadData()
        }
        delete.backgroundColor = UIColor.red
        return [delete]
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
