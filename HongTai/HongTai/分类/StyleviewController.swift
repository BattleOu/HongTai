//
//  StyleviewController.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/24.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit
import CoreData
class StyleviewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     var adHeaders:[String] = ["电子设备","男装/女装","家具","户外"]
    
     var diaryList: NSArray!
    fileprivate lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: 0, width: 80, height: ScreenHeight)
        leftTableView.rowHeight = 55
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.separatorColor = UIColor.clear
        leftTableView.register(CartTableViewCell.self, forCellReuseIdentifier: kLeftTableViewCell)
        return leftTableView
    }()
    
    fileprivate lazy var rightTableView : UITableView = {
        let rightTableView = UITableView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: 80, y: 20, width: ScreenWidth - 80, height: ScreenHeight - 64 )
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.register(RightTableViewCell.self, forCellReuseIdentifier: kRightTableViewCell)
        return rightTableView
    }()
    
    
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        let path = Bundle.main.bundlePath
        let plistName:NSString = "goodshow List.plist"
        let finalPath:NSString = (path as NSString).appendingPathComponent(plistName as String) as NSString
        diaryList = NSArray(contentsOfFile:finalPath as String)!
        // Do any additional setup after loading the view.
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

extension StyleviewController {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableView == tableView {
            
            return 1
        }
        else {
             return adHeaders.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return adHeaders.count
        }
        else {
            switch section {
            case 0:
                return 4
            case 1:
                return 4
            case 2:
                return 8
            case 3:
                return 2
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
             let cell = tableView.dequeueReusableCell(withIdentifier: kLeftTableViewCell, for: indexPath)
             if let myCell = cell as? CartTableViewCell
             {
            myCell.nameLabel.text = adHeaders[indexPath.row]
                return myCell
            }
            return cell
        }
        else {
             let cell = tableView.dequeueReusableCell(withIdentifier: kRightTableViewCell, for: indexPath)
            var list: [NSArray] = []
            for list2 in (diaryList as! [NSArray] ) {
                let a = list2[0] as! String
                if a == adHeaders[indexPath.section] {
                    list.append(list2)
                }
            }
            if list != [] {
            if let myCell = cell as? RightTableViewCell
            {
                myCell.nameLabel.text = list[indexPath.row][2] as? String
                var urlStr = NSURL(string: list[indexPath.row][7] as! String)!
                var request = NSURLRequest(url: urlStr as URL)
                var imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
                var img: UIImage? = nil
                img = UIImage(data: imgData!)!
                myCell.imageV.image = img
                myCell.priceLabel.text = "￥\(list[indexPath.row][3] as! String)"
                return myCell
            }
            }
             return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if leftTableView == tableView {
            return 0
        }
        return 20
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if leftTableView == tableView {
            return nil
        }
        let headerView = TableViewHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        headerView.nameLabel.text = adHeaders[section]
        return headerView
    }
    
    
    private func selectRow(index : Int) {
        leftTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向上，RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
        if (rightTableView == tableView)
            && !isScrollDown
            && (rightTableView.isDragging || rightTableView.isDecelerating) {
            selectRow(index: section)
        }
    }
    
    // TableView分区标题展示结束
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向下，RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
        if (rightTableView == tableView)
            && isScrollDown
            && (rightTableView.isDragging || rightTableView.isDecelerating) {
            selectRow(index: section + 1)
        }
    }
    // 当拖动右边 TableView 的时候，处理左边 TableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if leftTableView == tableView {
            selectIndex = indexPath.row
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        }
        else
        {
            var list: [NSArray] = []
            for list2 in (diaryList as! [NSArray] ) {
                let a = list2[0] as! String
                if a == adHeaders[indexPath.section] {
                    list.append(list2)
                }
            }
             if list != [] {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: goodsdetailController()))) as! goodsdetailController
                controller.img = (list[indexPath.row][7] as! String)
                controller.introduction = (list[indexPath.row][6] as! String)
                controller.name = (list[indexPath.row][2] as! String)
                controller.price = (list[indexPath.row][3] as! String)
                controller.salesnum = (list[indexPath.row][5] as! String)
                controller.stock = (list[indexPath.row][4] as! String)
                controller.godstyle = (list[indexPath.row][0] as! String)
            self.present(controller, animated: true)
            }
        }
    }
    
    // 标记一下 RightTableView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
    }
    
    

    
}
