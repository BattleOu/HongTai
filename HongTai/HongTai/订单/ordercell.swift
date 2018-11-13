//
//  ordercell.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/13.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class ordercell: UITableViewCell {

    @IBOutlet weak var goodimg: UIImageView!
    @IBOutlet weak var goodsname: UILabel!
    @IBOutlet weak var goodprice: UILabel!
    @IBOutlet weak var shouhuoren: UILabel!
    @IBOutlet weak var goodnum: UILabel!
    @IBOutlet weak var ordermoney: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
