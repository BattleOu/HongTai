//
//  RegisterViewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/12.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
   var users = [pop]()
    var user: pop?
    
    @IBOutlet weak var surepassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Realname: UITextField!
    @IBOutlet weak var usname: UITextField!
    //    let dataCellID = "dataCellID"
//    var dataArray: [User] = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        usname.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        usname.minimumFontSize=14  //最小可缩小的字号
        Realname.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        Realname.minimumFontSize=14  //最小可缩小的字号
        surepassword.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        surepassword.minimumFontSize=14  //最小可缩小的字号
        password.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        password.minimumFontSize=14  //最小可缩小的字号
        usname.clearButtonMode = .whileEditing
        Realname.clearButtonMode = .whileEditing
        password.clearButtonMode = .whileEditing
        surepassword.clearButtonMode = .whileEditing
        password.isSecureTextEntry = true //输入内容会显示成小黑点
        surepassword.isSecureTextEntry = true //输入内容会显示成小黑点
         password.placeholder="请输入密码"
        usname.placeholder="请输入用户名"
        Realname.placeholder="请输入姓名"
        surepassword.placeholder="请确认密码"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func save(_ sender: Any) {
        
      getLocalData()
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = NSTimeZone.local
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date as Date) as String
      if users.count > 0 {
       for x in 0...users.count - 1
       {
                if(usname.text == users[x].name)
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "用户名已被注册", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    print("duiduidi")
                }
        continue
        }
        if(usname.text == "" || password.text == "")
        {
            let alertController = UIAlertController(title: "提示!",
                                                    message: "用户名或密码不能为空", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(Realname.text == "")
        {
            let alertController = UIAlertController(title: "提示!",
                                                    message: "请填写真实姓名", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(surepassword.text == "")
        {
            let alertController = UIAlertController(title: "提示!",
                                                    message: "请确认密码", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(password.text != surepassword.text)
        {
            let alertController = UIAlertController(title: "提示!",
                                                    message: "密码不一致", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            
            let user = pop(userimg: UIImage(named: "avatar\(arc4random_uniform(5) + 1)")!.pngData()!, name: usname.text ?? "", password: password.text ?? "", realname: Realname.text ?? "", userbianhao: strNowTime , userupdate: Date() )
            
            RegisterViewController.insertData(contactInfo: user)
            let alertController = UIAlertController(title: "提示!",
                                                    message: "注册成功", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
      }
        else
      {
                 if(usname.text == "" || password.text == "")
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "用户名或密码不能为空", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                    else if(Realname.text == "")
                 {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "请填写真实姓名", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                 }
                else if(surepassword.text == "")
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "请确认密码", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else if(password.text != surepassword.text)
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "密码不一致", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            else
                {
        
                    let user = pop(userimg: UIImage(named: "avatar\(arc4random_uniform(5) + 1)")!.pngData()!, name: usname.text ?? "", password: password.text ?? "", realname: Realname.text ?? "", userbianhao: strNowTime , userupdate: Date() )
                    
                    RegisterViewController.insertData(contactInfo: user)
                    
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "注册成功", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: {
                        action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            }
        }
    }
        
    }




extension RegisterViewController {
    
    
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
    
    class func insertData(contactInfo: pop) {
        
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        //        步骤三：保存数值
        
        user.setValue(contactInfo.userimg, forKey: "userimage")
        user.setValue(contactInfo.userbianhao, forKey: "userid")
        user.setValue(contactInfo.password, forKey: "userpassword")
        user.setValue(contactInfo.name, forKey: "username")
        user.setValue(contactInfo.realname, forKey: "userrealname")
        user.setValue(contactInfo.userupdate, forKey: "userupdate")
        
        
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
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
