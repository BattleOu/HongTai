//
//  SearchTableViewCell.swift
//  HongTai
//
//  Created by 周旭 on 2018/10/25.
//  Copyright © 2018年 欧张帆. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell,UISearchBarDelegate {
    var search:UISearchBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        search = UISearchBar(frame:CGRect(x: 60, y:30, width:220, height:400))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.placeholder = "输入文字搜索商品"
        search.delegate = self
        self.contentView.addSubview(search)
        
//        let frame = CGRect(x: 0, y: 80, width: ScreenWidth, height: ScreenHeight*0.6)
//        let imageView = ["iMac1.jpg","2.jpg","iphone8-gallery4-2017.jpg","Macbook.jpg"]
//
//        let loopView = JHLoopView(frame: frame, images: imageView as NSArray, autoPlay: true, delay: 3, isFromNet: false)
//        loopView.delegate = self
//
//        self.contentView.addSubview(loopView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//extension SearchTableViewCell : JHLoopViewDelegate {
//    func adLoopView(_ adLoopView: JHLoopView, IconClick index: NSInteger) {
//        print(index)
//    }
//}
