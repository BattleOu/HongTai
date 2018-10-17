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
    
   var users = [sss]()
    var user: sss?
    
    @IBOutlet weak var surepassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Realname: UITextField!
    @IBOutlet weak var usname: UITextField!
    //    let dataCellID = "dataCellID"
//    var dataArray: [User] = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        usname.placeholder = "请输入用户名"
        usname.clearButtonMode = .whileEditing
        Realname.placeholder = "请输入真实姓名"
        Realname.clearButtonMode = .whileEditing
        password.placeholder = "请输入密码 "
        password.clearButtonMode = .whileEditing
        surepassword.placeholder = "请确认密码"
        surepassword.clearButtonMode = .whileEditing
//         CoreDataManager.shared.deleteAllPerson()
        // Do any additional setup after loading the view.
    }
    
//    lazy var context: NSManagedObjectContext = {
//        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
//        return context
//    }()
    
    @IBAction func save(_ sender: Any) {
        let date = NSDate()
        let str = NSString()
                let timeFormatter = DateFormatter()
                timeFormatter.timeZone = NSTimeZone.local
                timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                let strNowTime = timeFormatter.string(from: date as Date) as String
        getLocalData()
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
            
            let user = sss(userimg: UIImage(named: "avatar\(arc4random_uniform(5) + 1)")!.pngData()!, name: usname.text ?? "", password: password.text ?? "", realname: Realname.text ?? "", userbianhao: strNowTime , userupdate: Date() )
            
            fangfaViewController.insertData(contactInfo: user)
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
        
        let user = sss(userimg: UIImage(named: "avatar\(arc4random_uniform(5) + 1)")!.pngData()!, name: usname.text ?? "", password: password.text ?? "", realname: Realname.text ?? "", userbianhao: strNowTime , userupdate: Date() )
                    
            fangfaViewController.insertData(contactInfo: user)
                    
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


//extension RegisterViewController {
//
//
//    @IBAction func zhuce(_ sender: Any) {
//        resignKeyboard()
//          let User = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
//        guard let usernameString = username.text else { return }
//        guard let realnameString = realname.text else { return }
//        guard let passwordString = password.text else { return }
//        guard surepassword.text != nil else { return }
//        let date = NSDate()
//
//        let timeFormatter = DateFormatter()
//        timeFormatter.timeZone = NSTimeZone.local
//        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
//        let strNowTime = timeFormatter.string(from: date as Date) as String
//
//        let time = DateFormatter()
//        time.timeZone = NSTimeZone.local
//        time.dateFormat = "yyyy-MM-dd"
//        let birthtime = time.string(from: date as Date) as String
//
//        let imagestring = UIImage(named: "蔡徐坤")!.pngData()
//        // 保存数据
//        if(username.text == )
//        {
//            let alertController = UIAlertController(title: "提示!",
//                                                    message: "用户名已被注册", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//
//        }
//        else if(username.text == "" || password.text == "")
//        {
//            let alertController = UIAlertController(title: "提示!",
//                                                    message: "用户名或密码不能为空", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//        else if(surepassword.text == "")
//        {
//            let alertController = UIAlertController(title: "提示!",
//                                                    message: "请确认密码", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//        else if(password.text != surepassword.text)
//        {
//            let alertController = UIAlertController(title: "提示!",
//                                                    message: "密码不一致", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//        else
//        {
//            CoreDataManager.shared.savePersonWith(userid: strNowTime, username: usernameString, userpassword: passwordString, userrelaname: realnameString, birthday: birthtime, userimage: imagestring!)
//            let alertController = UIAlertController(title: "提示!",
//                                                    message: "注册成功", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "确定", style: .default,handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//
//    private func resignKeyboard() {
//        username.resignFirstResponder()
//        realname.resignFirstResponder()
//        password.resignFirstResponder()
//        surepassword.resignFirstResponder()
//    }

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
    
    fileprivate func translateData(from: NSManagedObject) -> (sss?) {
        
        if let img = from.value(forKey: "userimage") as? Data,let useid = from.value(forKey: "userid") as? String,let name = from.value(forKey: "username") as? String,let updateTime = from.value(forKey: "userupdate") as? Date, let password = from.value(forKey: "userpassword") as? String, let realname = from.value(forKey: "userrelaname") as? String{
            let user = sss(userimg: img, name: name, password:password, realname: realname, userbianhao: useid , userupdate: updateTime )
            
            return user
        }
        return nil
    }
}
