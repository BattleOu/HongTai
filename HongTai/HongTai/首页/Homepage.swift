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
    }


}

