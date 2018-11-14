//
//  personDetailsViewController.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/11/1.
//  Copyright © 2018 欧张帆. All rights reserved.
//

import UIKit
import CoreData

class personDetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var gainame: UITextField!
    @IBOutlet weak var gairealname: UITextField!
    var users = [pop]()
    var user: pop?
    var orders = [orderss]()
    var oorder: orderss?
     var dataModel = DataModel()
    var i : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        personImage.layer.cornerRadius = min(personImage.bounds.size.width, personImage.bounds.size.height) * 0.5
        personImage.layer.masksToBounds = true
        dataModel.loadData()
        let icount = dataModel.userliebiao.count - 1
        for x in 0...icount
        {
            let kan = dataModel.userliebiao[x].image
            let image = UIImage(data: kan)
             personImage.image = image
            gainame.text = dataModel.userliebiao[x].name
            gairealname.text = dataModel.userliebiao[x].realname
            
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func chooseimage(_ sender: Any) {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //查看info对象
        print(info)
        //显示的图片
        let image:UIImage!
        //获取选择的原图
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        personImage.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
    @IBAction func save(_ sender: Any) {
        getLocalData()
        //获取委托
        let app = UIApplication.shared.delegate as! AppDelegate
        func getContext() -> NSManagedObjectContext{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            return appDelegate.persistentContainer.viewContext
        }
        //获取数据上下文对象
        let context = getContext()
        //声明数据的请求，声明一个实体结构
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //查询条件
        fetchRequest.predicate = NSPredicate(format: "username = '\(dataModel.userliebiao[0].name)'")
        // 返回结果在finalResult中
        
        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
         //对返回的数据做处理。
            let fetchObject  = result.finalResult! as! [User]
//            if self.users.count > 0 {
//            for x in 0...self.users.count - 1
//            {
            if(self.gainame.text == "" || self.gairealname.text == "")
            {
                let alertController = UIAlertController(title: "提示!",message: "内容不能空！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let expression = "^[a-zA-Z0-9_-]{3,16}$"
            let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
            
            let numberOfMatches = regex.numberOfMatches(in: self.gainame.text!, options:.reportProgress, range: NSMakeRange(0, (self.gainame.text! as NSString).length))//获取匹配的个数
            
            let expression1 = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
            let regex1 = try! NSRegularExpression(pattern: expression1, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
            
            let numberOfMatches1 = regex1.numberOfMatches(in: self.gairealname.text!, options:.reportProgress, range: NSMakeRange(0, (self.gairealname.text! as NSString).length))//获取匹配的个数
//            else{
           if(numberOfMatches == 0)
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "用户名格式错误", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if(numberOfMatches1 == 0)
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "请输入有效真实姓名", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
                for x in 0...self.users.count - 1
                {
                    for c in fetchObject{
                        if(self.gainame.text == self.users[x].name&&self.gainame.text != c.username)
                        {
                            let alertController = UIAlertController(title: "提示!",message: "用户名不能重复", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            return
                        }
                    }
                    continue
                }
            for x in 0...self.users.count - 1
            {
                for c in fetchObject{
                    if(self.gainame.text != self.users[x].name||self.gainame.text == c.username)
                    {
                        let show = self.personImage.image
                                        let see =  show!.pngData()
                                        c.userimage = see
                                        c.username = self.gainame.text
                                        c.userrealname = self.gairealname.text
                                        app.saveContext()
                                        print("存入")
                                        let alertController = UIAlertController(title: "提示!", message: "保存成功", preferredStyle: .alert)
                                        let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                                            action in
                                            self.performSegue(withIdentifier: "xiugai", sender: self)
                                        })
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
                        fetchRequest.predicate = NSPredicate(format: "username = '\(self.dataModel.userliebiao[0].name)'")
                        // 返回结果在finalResult中
                        
                        //        let asyncFecthRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult!) in
                        //            //对返回的数据做处理。
                        //            let fetchObject  = result.finalResult! as! [Cart]
                        let fetchObject = try? context.fetch(fetchRequest) as! [NSManagedObject]
                        for c in fetchObject as! [Orders]
                        {
                            c.username = self.gainame.text
                             app.saveContext()
                        }
                                        self.dataModel.loadData()
                                        self.dataModel.userliebiao = [UserInfo(name: self.gainame.text!, password: c.userpassword!, id: c.userid!, image: see!, realname: self.gairealname.text!, update: c.userupdate!)]
                                        self.dataModel.saveData()
                                        print("沙盒存入")
                                        alertController.addAction(okAction)
                                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                }
            }    
        }
        // 执行异步请求调用execute
        do {
            
            try context.execute(asyncFecthRequest)
            
        } catch  {
            
            print("error")
            
        }
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
extension personDetailsViewController {
    fileprivate func getLocalData() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                users.removeAll()
                for result in results {
                    guard let user = translateData(from: result) else { return }
                    users.append(user)
                }
            }
            
        } catch  {
            fatalError("获取失败")
        }
        
    }
    
    fileprivate func translateData(from: NSManagedObject) -> (pop?) {
        
        if let img = from.value(forKey: "userimage") as? Data,let useid = from.value(forKey: "userid") as? String,let name = from.value(forKey: "username") as? String,let updateTime = from.value(forKey: "userupdate") as? Date, let password = from.value(forKey: "userpassword") as? String, let realname = from.value(forKey: "userrealname") as? String{
            let user = pop(userimg: img, name: name, password:password, realname: realname, userbianhao: useid , userupdate: updateTime )
            
            return user
        }
        return nil
    }
}


extension personDetailsViewController {
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
