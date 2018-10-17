//
//  LoginViewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/12.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    var users = [sss]()
    var user: sss?
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        username.minimumFontSize=14  //最小可缩小的字号
        password.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        password.minimumFontSize=14  //最小可缩小的字号
        username.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        username.clearButtonMode = .unlessEditing  //编辑时不出现，编辑后才出现清除按钮
        username.clearButtonMode = .always  //一直显示清除按钮
        password.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        password.clearButtonMode = .unlessEditing  //编辑时不出现，编辑后才出现清除按钮
        password.clearButtonMode = .always  //一直显示清除按钮
        password.isSecureTextEntry = true //输入内容会显示成小黑点
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        getLocalData()
        if users.count > 0 {
            for x in 0...users.count - 1
            {
                if(username.text == users[x].name && password.text == users[x].password)
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "登录成功", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "确认", style: .default,handler: {
                        action in
                           let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: Homepage()))) as! Homepage
                        controller.nameuser = self.username.text
                        self.present(controller, animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                continue
                
            }
            
            
            for x in 0...users.count - 1
            {
            if(username.text != users[x].name && password.text == users[x].password)
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "用户名未注册", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            continue
            }
            
            
            for x in 0...users.count - 1
            {
                if(username.text == users[x].name && password.text != users[x].password)
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "密码错误", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                continue
            }
            
            for x in 0...users.count - 1
            {
                if(username.text != users[x].name && password.text != users[x].password)
                {
                    let alertController = UIAlertController(title: "提示!",
                                                            message: "查无此用户", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                continue
            }
            }
            
            if(username.text == "" || password.text == "")
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "用户名或密码不能为空", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
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
extension LoginViewController {
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
