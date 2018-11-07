//
//  PersonViewController.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/10/12.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var usernam: UILabel!
    var dataModel = DataModel()
     var modeldata = CartModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.loadData()
        if(dataModel.userliebiao.isEmpty)
        {
            self.performSegue(withIdentifier: "kong", sender: self)
        }
        else
        {
            let icount = dataModel.userliebiao.count - 1
            for x in 0...icount
            {
                let kan = dataModel.userliebiao[x].image
                let image = UIImage(data: kan)
                imgview.image = image
                usernam.text = dataModel.userliebiao[x].name

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
    
    @IBAction func shanchu(_ sender: Any) {
        dataModel.loadData()
        dataModel.userliebiao.removeAll()
        dataModel.saveData()
        modeldata.loadData()
        modeldata.cartlist.removeAll()
        modeldata.saveData()
        print("删除了")
         let controller =
        self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: navigationViewController()))) as! navigationViewController
        self.present(controller, animated: true)
    }

}
