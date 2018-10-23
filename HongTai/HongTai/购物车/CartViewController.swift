//
//  CartViewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/23.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData
class CartViewController: UIViewController {
    @IBOutlet weak var Tableview: UITableView!
    var sty = [Goodsstyle]()
    var style:Goodsstyle?
    override func viewDidLoad() {
        super.viewDidLoad()
        Tableview.delegate = self
        Tableview.dataSource = self
        getLocalData1()
        if sty.count == 0 {
            initData1()
        }
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
extension CartViewController {
    fileprivate func getLocalData1() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goodstyle")
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                sty.removeAll()
                for result in results {
                    guard let goooood = translateData1(from: result) else { return }
                    sty.append(goooood)
                }
                Tableview.reloadData()
            }
        } catch  {
            fatalError("获取失败")
        }
    }
    
    
    class func insertData1(contactInfo: Goodsstyle) {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Goodstyle", in: managedObectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        user.setValue(contactInfo.goodstylenum, forKey: "goodstyleid")
        user.setValue(contactInfo.goodnum, forKey: "goodsid")
        user.setValue(contactInfo.goodstylename, forKey: "goodstylename")
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
    }
    
    fileprivate func initData1() {
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = NSTimeZone.local
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        
        let timeFormatter1 = DateFormatter()
        timeFormatter1.timeZone = NSTimeZone.local
        timeFormatter1.dateFormat = "yyyy-MM-dd HH:mm"
        let strNowTime1 = timeFormatter.string(from: date as Date) as String
        
        let user1 = Goodsstyle(goodnum:strNowTime, goodstylename:"电器", goodstylenum:strNowTime1)
        let user2 = Goodsstyle(goodnum:"1441414", goodstylename:"食品", goodstylenum:"151212")
        let user3 = Goodsstyle(goodnum:"d12s15s", goodstylename:"乐器", goodstylenum:"515sss")
        let user4 = Goodsstyle(goodnum:"1111ccvv", goodstylename:"家具", goodstylenum:"151212")
        CartViewController.insertData1(contactInfo: user1)
        CartViewController.insertData1(contactInfo: user2)
        CartViewController.insertData1(contactInfo: user3)
        CartViewController.insertData1(contactInfo: user4)
        sty.append(user1)
        sty.append(user2)
        sty.append(user3)
        sty.append(user4)
    }
    
    fileprivate func translateData1(from: NSManagedObject) -> (Goodsstyle?) {
        if let goodid = from.value(forKey: "goodsid") as? String,let goodstyid = from.value(forKey: "goodstyleid") as? String, let goodstyname = from.value(forKey: "goodstylename") as? String{
            let good = Goodsstyle(goodnum: goodid, goodstylename: goodstyname, goodstylenum: goodstyid)
            return good
        }
        return nil
    }
}

extension CartViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart", for: indexPath)
        
        if let myCell = cell as? CartTableViewCell {
            myCell.cartlbl.text = sty[indexPath.row].goodstylename
            
            return myCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
