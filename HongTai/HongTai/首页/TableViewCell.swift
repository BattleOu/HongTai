//
//  TableViewCell.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/22.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblgood: UILabel!
    @IBOutlet weak var picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        picture.layer.cornerRadius = min(picture.bounds.size.width, picture.bounds.size.height) * 1
        picture.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
