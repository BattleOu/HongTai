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
    @IBOutlet weak var logining: UIButton!
    var search:UISearchBar!
    var nameuser:String!
    var label:UILabel!
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
    }
    
//    @objc func methodName() {
//         let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController()))) as! LoginViewController
//        self.present(controller, animated: true)
//    }
//    @objc func someMethod() {
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: RegisterViewController()))) as! RegisterViewController
//        self.present(controller, animated: true)
//    }
    
    @IBAction func login(_ sender: Any) {
        self.performSegue(withIdentifier: "login",sender:self);
    }
    

}

//遵循协议代理，调用代理方法
extension Homepage : JHLoopViewDelegate {
    func adLoopView(_ adLoopView: JHLoopView, IconClick index: NSInteger) {
        print(index)
    }
}

