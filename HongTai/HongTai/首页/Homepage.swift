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
    override func viewDidLoad() {
        super.viewDidLoad()
        search = UISearchBar(frame:CGRect(x: 60, y:30, width:350, height:40))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.delegate = self
        view.addSubview(search)
        
        let frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: view.bounds.width*0.6)
        let imageView = ["iMac1.jpg","2.jpg","iphone8-gallery4-2017.jpg","Macbook.jpg"]
        
        let loopView = JHLoopView(frame: frame, images: imageView as NSArray, autoPlay: true, delay: 3, isFromNet: false)
        loopView.delegate = self
        
        view.addSubview(loopView)
    }


}

//遵循协议代理，调用代理方法
extension Homepage : JHLoopViewDelegate {
    func adLoopView(_ adLoopView: JHLoopView, IconClick index: NSInteger) {
        print(index)
    }
}

