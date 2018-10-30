//
//  RightTableViewCell.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/24.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {

     lazy var nameLabel = UILabel()
     lazy var imageV = UIImageView()
     lazy var priceLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    func configureUI() {
        imageV.frame = CGRect(x: 15, y: 15, width: 50, height: 50)
        contentView.addSubview(imageV)
        
        nameLabel.frame = CGRect(x: 80, y: 10, width: 200, height: 30)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        
        priceLabel.frame = CGRect(x: 80, y: 45, width: 200, height: 30)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor.red
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

