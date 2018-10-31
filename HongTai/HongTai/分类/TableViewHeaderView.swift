//
//  TableViewHeaderView.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/24.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {

    lazy var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(253,212,49)
        nameLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
