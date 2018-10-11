//
//  ViewController.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/10/9.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

import Alamofire

class ViewController: UIViewController,UISearchBarDelegate {
var search:UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        search = UISearchBar(frame:CGRect(x: 40, y:20, width:350, height:50))
        // Do any additional setup after loading the view, typically from a nib.
        search.barTintColor = UIColor.white
        search.delegate = self
        view.addSubview(search)
    }


}

