//
//  HomeViewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/7.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,UISearchBarDelegate  {
   var dataModel = StyleModel()
    var search:UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "GoodsList", bundle: nil), forCellReuseIdentifier: "GoodsList")
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = UIColor.orange
        search = UISearchBar(frame:CGRect(x: 0, y:5, width:330, height:20))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.placeholder = "输入文字搜索商品"
        search.delegate = self
        var logo = UIImageView(image:UIImage(named: "5b7e86cdcb2cf_03"))
        var rightNavBarButton = UIBarButtonItem(customView:search)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        self.navigationItem.titleView = logo
        dataModel.loadData()
        dataModel.userList.removeAll()
        dataModel.saveData()
        let frame = CGRect(x: 0, y: 10, width: view.bounds.width, height: view.bounds.width*0.6)
                let imageView = ["iMac1.jpg","2.jpg","iphone8-gallery4-2017.jpg","Macbook.jpg"]
        
                let loopView = JHLoopView(frame: frame, images: imageView as NSArray, autoPlay: true, delay: 3, isFromNet: false)
                loopView.delegate = self
        
                tableView.addSubview(loopView)
        if dataModel.userList.count == 0
        {
            dataModel.userList.append(Styleinfo(goodsid:"1",goodsimg: "https://img.alicdn.com/imgextra/i4/268451883/TB24PFChf5TBuNjSspmXXaDRVXa_!!268451883.png_60x60q90.jpg",goodstyle: "电子设备", goodsname: "苹果ipad", introduction:  "18新款Apple/苹果 iPad 2018款 9.7英寸32/128Gwifi 平板电脑 3/6/12期分期 正品国行 全国联保",marketprice: "3008",salesnum: "2060",stock: "6013" ))
            dataModel.userList.append(Styleinfo(goodsid:"2",goodsimg: "https://img.alicdn.com/imgextra/i2/4129257698/TB2o2UTvSMmBKNjSZTEXXasKpXa_!!4129257698.jpg_60x60q90.jpg",goodstyle: "电子设备", goodsname: "苹果笔记本电脑", introduction:  "Apple/苹果笔记本电脑MacBook Pro13英寸256G轻薄便携商务办公学生笔记本带触控2018款",marketprice: "13588",salesnum: "115",stock: "2565" ))
            dataModel.userList.append(Styleinfo(goodsid:"3",goodsimg: "https://gd4.alicdn.com/imgextra/i4/2951536224/TB22Jn2gYYI8KJjy0FaXXbAiVXa_!!2951536224.jpg_50x50.jpg",goodstyle: "电子设备", goodsname: "苹果一体机", introduction:  "Apple苹果一体机 iMAC 21.5 27寸ME087MK462超薄办公设计台式电脑",marketprice: "12120",salesnum: "71",stock: "614" ))
            dataModel.userList.append(Styleinfo(goodsid:"4",goodsimg: "https://img.alicdn.com/imgextra/i4/268451883/O1CN011PmSGIxD39MObrY_!!268451883.jpg_60x60q90.jpg",goodstyle: "电子设备", goodsname: "苹果手表", introduction:  "2018款 Apple Watch Series 4 苹果手表运动智能心率电话手表s4手环",marketprice: "3199",salesnum: "115",stock: "5656" ))
            dataModel.userList.append(Styleinfo(goodsid:"5",goodsimg: "https://gd1.alicdn.com/imgextra/i1/78123130/O1CN011Yza9eScmgZZhVK_!!78123130.jpg_50x50.jpg",goodstyle: "男装/女装", goodsname: "呢子大衣", introduction:  "MALI/2018新款双面呢子大衣女秋冬中长款羊毛气质毛呢外套",marketprice: "911",salesnum: "2060",stock: "6013" ))
            dataModel.userList.append(Styleinfo(goodsid:"6",goodsimg: "https://gd4.alicdn.com/imgextra/i2/0/TB1zqu.QpXXXXbKXFXXXXXXXXXX_!!0-item_pic.jpg_50x50.jpg",goodstyle: "男装/女装", goodsname: "牛仔夹克外套", introduction:  "Levis李维斯男士牛仔夹克外套纯棉纯色长袖72334-0130 余文乐同款",marketprice: "498",salesnum: "23",stock: "652" ))
            dataModel.userList.append(Styleinfo(goodsid:"7",goodsimg: "https://gd1.alicdn.com/imgextra/i1/425119012/T2r5F4XClXXXXXXXXX_!!425119012.jpg_50x50.jpg",goodstyle: "男装/女装", goodsname: "羽绒服", introduction:  "天天特价军工羽绒服男户外中长款加厚防风拆卸内胆活里活面羽绒服",marketprice: "499",salesnum: "236",stock: "2625" ))
            dataModel.saveData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return dataModel.userList.count
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            //用重用的方式获取标识为wifiCell的cell
            dataModel.loadData()
            let cell:GoodsList = tableView.dequeueReusableCell(withIdentifier: "GoodsList",
                                                                   for: indexPath) as! GoodsList
            cell.namegood.text = dataModel.userList[indexPath.row].goodsname
            print(dataModel.userList[indexPath.row].goodsname)
            let urlStr = NSURL(string: dataModel.userList[indexPath.row].goodsimg)!
            let request = NSURLRequest(url: urlStr as URL)
            let imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
            var img: UIImage? = nil
            img = UIImage(data: imgData!)!
            cell.imagepic.image = img
            cell.money.text = "￥" + dataModel.userList[indexPath.row].marketprice
            return cell
        }
        else{
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
           return view.bounds.width*0.65
        }
        return 100
        
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 {
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        }
        return super.tableView(tableView, indentationLevelForRowAt: indexPath)
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1
    {
        dataModel.loadData()
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: goodsdetailController()))) as! goodsdetailController
        controller.img = dataModel.userList[indexPath.row].goodsimg
        controller.introduction = dataModel.userList[indexPath.row].introduction
        controller.name = dataModel.userList[indexPath.row].goodsname
        controller.price =  dataModel.userList[indexPath.row].marketprice
        controller.salesnum =  dataModel.userList[indexPath.row].salesnum
        controller.stock = dataModel.userList[indexPath.row].stock
        controller.godstyle = dataModel.userList[indexPath.row].goodstyle
        self.present(controller, animated: true)
    }
    }
    
    

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
extension HomeViewController : JHLoopViewDelegate {
    func adLoopView(_ adLoopView: JHLoopView, IconClick index: NSInteger) {
        print(index)
    }
}
