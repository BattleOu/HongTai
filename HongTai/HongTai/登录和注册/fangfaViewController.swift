//
//  fangfaViewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/16.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData

class fangfaViewController: UIViewController {

    var datas = [sss]()
    
    var selectedUser: sss?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension fangfaViewController {
    
    class func insertData(contactInfo: sss) {
        
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
    
    
}
