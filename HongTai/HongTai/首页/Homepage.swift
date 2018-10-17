//
//  ViewController.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/10/9.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

import Alamofire

class Homepage: UIViewController,UISearchBarDelegate {
var search:UISearchBar!
    var nameuser:String!
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
        
        var button:UIButton = UIButton(type:.contactAdd)
        button = UIButton(frame: CGRect(x: 300, y: 40, width: 50, height: 20))
//        label.titleLabel?.textColor = UIColor.gray
//        label.titleLabel?.text = "登录/"
        button.setTitle("登录/", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont(name:"Arial-BoldItalicMT", size:15)
        
         view.addSubview(button)
//        lab = UIButton(frame: CGRect(x: 345, y: 40, width: 40, height: 20))
//        lab.titleLabel?.textColor = UIColor.gray
//        lab.titleLabel?.text = "注册"
//        lab.titleLabel?.font = UIFont(name:"Zapfino", size:15)
//         view.addSubview(lab)
        
        var zhucebutton:UIButton = UIButton(type:.contactAdd)
        zhucebutton = UIButton(frame: CGRect(x: 340, y: 40, width: 40, height: 20))
        //        label.titleLabel?.textColor = UIColor.gray
        //        label.titleLabel?.text = "登录/"
        zhucebutton.setTitle("注册", for: .normal)
        zhucebutton.setTitleColor(UIColor.gray, for: .normal)
        zhucebutton.titleLabel?.font = UIFont(name:"Arial-BoldItalicMT", size:15)
        view.addSubview(zhucebutton)
    }


}

//遵循协议代理，调用代理方法
extension Homepage : JHLoopViewDelegate {
    func adLoopView(_ adLoopView: JHLoopView, IconClick index: NSInteger) {
        print(index)
    }
}

