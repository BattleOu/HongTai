//
//  CartCell.swift
//  HongTai
//
//  Created by 欧张帆 on 2018/11/8.
//  Copyright © 2018 欧张帆. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    var modeldata = CartModel()
    @IBOutlet weak var imagesgood: UIImageView!
    @IBOutlet weak var godsname: UILabel!
    @IBOutlet weak var godsprice: UILabel!
    @IBOutlet weak var godstotal: UILabel!
    @IBOutlet weak var godsnum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
