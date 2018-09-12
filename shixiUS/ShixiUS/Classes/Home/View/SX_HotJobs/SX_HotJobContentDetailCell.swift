//
//  SX_HotJobContentDetailCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/10.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位的 工作职责 应聘要求

/*
 你是我的前因
 我又是谁的果报
 灯火阑珊，为你写下情诗三行
 */

import UIKit

class SX_HotJobContentDetailCell: UITableViewCell {
    
    var titleLabel : UILabel?
    var contentLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// ==================================================================================================================
// MARK: - configCell()
// =================================================================================================================
extension SX_HotJobContentDetailCell {
    
    func configCell() {
        
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.width.equalToSuperview()
            make.height.equalTo(17)
        }).config({ (TITLE) in
            TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            TITLE.font = UIFont.boldSystemFont(ofSize: 16)
            TITLE.sizeToFit()
        })
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })
        
        self.contentLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }).config({ (CONTENT) in
            CONTENT.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            CONTENT.font = UIFont.systemFont(ofSize: 13)
            CONTENT.numberOfLines = 0
        })
    }
}
