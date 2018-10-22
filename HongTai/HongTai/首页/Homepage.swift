//
//  Homepage.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/22.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
class Homepage: UIViewController,UISearchBarDelegate {
    
    var search:UISearchBar!
    var nameuser:String!
    var label:UILabel!
    var god = [goodgood]()
    var godd:goodgood?
    @IBOutlet weak var logingin: UIButton!
    @IBOutlet weak var Tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        search = UISearchBar(frame:CGRect(x: 60, y:30, width:220, height:40))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.placeholder = "输入文字搜索商品"
        search.delegate = self
        view.addSubview(search)
        
        let frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: view.bounds.width*0.6)
        let imageView = ["iMac1.jpg","2.jpg","iphone8-gallery4-2017.jpg","Macbook.jpg"]
        
        let loopView = JHLoopView(frame: frame, images: imageView as NSArray, autoPlay: true, delay: 3, isFromNet: false)
        loopView.delegate = self
        
        view.addSubview(loopView)
        
        
        Tableview.delegate = self
        Tableview.dataSource = self
        getLocalData()
        if god.count == 0 {
            initData()
        }
        
        if (nameuser == nil)
        {
            logining.isHidden = false
            //        var button:UIButton = UIButton(type:.contactAdd)
            //        button = UIButton(frame: CGRect(x: 300, y: 40, width: 50, height: 20))
            ////        label.titleLabel?.textColor = UIColor.gray
            ////        label.titleLabel?.text = "登录/"
            //        button.setTitle("登录/", for: .normal)
            //        button.setTitleColor(UIColor.gray, for: .normal)
            //        button.titleLabel?.font = UIFont(name:"Arial-BoldItalicMT", size:15)
            //        button.addTarget(self,action:#selector(methodName), for: .touchUpInside)
            //         view.addSubview(button)
            ////        lab = UIButton(frame: CGRect(x: 345, y: 40, width: 40, height: 20))
            ////        lab.titleLabel?.textColor = UIColor.gray
            ////        lab.titleLabel?.text = "注册"
            ////        lab.titleLabel?.font = UIFont(name:"Zapfino", size:15)
            ////         view.addSubview(lab)
            //
            //        var zhucebutton:UIButton = UIButton(type:.contactAdd)
            //        zhucebutton = UIButton(frame: CGRect(x: 350, y: 40, width: 40, height: 20))
            //        //        label.titleLabel?.textColor = UIColor.gray
            //        //        label.titleLabel?.text = "登录/"
            //        zhucebutton.setTitle("注册", for: .normal)
            //        zhucebutton.setTitleColor(UIColor.gray, for: .normal)
            //        zhucebutton.titleLabel?.font = UIFont(name:"Arial-BoldItalicMT", size:15)
            //        button.addTarget(self,action:#selector(someMethod), for: .touchUpInside)
            //        view.addSubview(zhucebutton)
        }
        else
        {
            label = UILabel(frame: CGRect(x: 280, y: 40, width: 150, height: 20))
            label.textColor = UIColor.gray
            label.text = "欢迎" + nameuser + "登录!"
            label.font = UIFont(name:"Arial-BoldItalicMT", size:12)
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            label.numberOfLines = 0
            view.addSubview(label)
            logining.setTitle("注销", for: .normal)
            logining.titleLabel?.font = UIFont(name:"Arial-BoldItalicMT", size:12)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func lgoing(_ sender: Any) {
        self.performSegue(withIdentifier: "login",sender:self);
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
extension Homepage : JHLoopViewDelegate {
    func adLoopView(_ adLoopView: JHLoopView, IconClick index: NSInteger) {
        print(index)
    }
}

extension Homepage {
    fileprivate func getLocalData() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goods")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                god.removeAll()
                for result in results {
                    guard let goooood = translateData(from: result) else { return }
                    god.append(goooood)
                }
                
                Tableview.reloadData()
            }
            
        } catch  {
            fatalError("获取失败")
        }
    }
    
    class func insertData(contactInfo: goodgood) {
        
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Goods", in: managedObectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        
        user.setValue(contactInfo.goodsimg, forKey: "goodsimg")
        user.setValue(contactInfo.goodsbianhao, forKey: "goodsid")
        user.setValue(contactInfo.goodsname, forKey: "goodsname")
        user.setValue(contactInfo.goodsintroduction, forKey: "introduction")
        user.setValue(contactInfo.goodsprice, forKey: "marketprice")
        user.setValue(contactInfo.stock, forKey: "stock")
        user.setValue(contactInfo.salesnum, forKey: "salesnum")
        user.setValue(contactInfo.goodstime, forKey: "goodstime")
        user.setValue(contactInfo.goodsstate, forKey: "goodstate")
        
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        
    }
    
    
    fileprivate func initData() {
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = NSTimeZone.local
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        let data1 = #imageLiteral(resourceName: "avatar2").pngData()
        let user1 = goodgood(goodsimg: data1!, goodsbianhao: strNowTime, goodsname: "液晶电视", goodsintroduction: "超级好看的液晶电视", goodsprice: "¥40", stock: "1000", salesnum: "60", goodstime: Date(), goodsstate: "已上架")
        let data2 = #imageLiteral(resourceName: "avatar1").pngData()
        let user2 = goodgood(goodsimg: data2!, goodsbianhao: "2222", goodsname: "海尔冰箱", goodsintroduction: "超级好看的冰箱", goodsprice: "¥100", stock: "1500", salesnum: "80", goodstime: Date(), goodsstate: "已上架")
        Homepage.insertData(contactInfo: user1)
        Homepage.insertData(contactInfo: user2)
        god.append(user1)
        god.append(user2)
    }
    fileprivate func translateData(from: NSManagedObject) -> (goodgood?) {
        if let imgData = from.value(forKey: "goodsimg") as? Data,let goodsid = from.value(forKey: "goodsid") as? String,let goodsname = from.value(forKey: "goodsname") as? String,let introduction = from.value(forKey: "introduction") as? String, let godprice = from.value(forKey: "marketprice") as? String, let stock = from.value(forKey: "stock") as? String, let salesnum = from.value(forKey: "salesnum") as? String, let goodstime = from.value(forKey: "goodstime") as? Date, let goodsstate = from.value(forKey: "goodstate") as? String{
            let good = goodgood(goodsimg: imgData, goodsbianhao: goodsid, goodsname: goodsname, goodsintroduction: introduction, goodsprice: godprice, stock: stock, salesnum: salesnum, goodstime: goodstime, goodsstate: goodsstate)
            return good
        }
        return nil
    }
}

extension Homepage:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return god.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goods", for: indexPath)
        
        if let myCell = cell as? TableViewCell {
            myCell.lblgood.text = god[indexPath.row].goodsname
            myCell.picture.image = UIImage(data: god[indexPath.row].goodsimg)
            return myCell
        }
        return cell
    }
}
