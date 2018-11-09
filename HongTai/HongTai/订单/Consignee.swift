//
//  onsignee.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/9.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class Consignee: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var consigneename: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var consigneeadress: UITextField!
    @IBOutlet weak var ordersmoney: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func orders(_ sender: Any) {
    }
    @IBAction func back(_ sender: Any) {
          self.performSegue(withIdentifier: "back", sender: self)
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
