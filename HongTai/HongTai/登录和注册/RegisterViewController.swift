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

    
//    let dataCellID = "dataCellID"
//    var dataArray: [User] = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
//         CoreDataManager.shared.deleteAllPerson()
        // Do any additional setup after loading the view.
    }
    
//    lazy var context: NSManagedObjectContext = {
//        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
//        return context
//    }()
    
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

