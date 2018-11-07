//
//  GoodsList.swift
//  HongTai
//
//  Created by 周旭 on 2018/11/7.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class GoodsList: UITableViewCell {

    @IBOutlet weak var imagepic: UIImageView!
    @IBOutlet weak var namegood: UILabel!
    @IBOutlet weak var money: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
