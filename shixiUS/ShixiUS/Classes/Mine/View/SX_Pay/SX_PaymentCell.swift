//
//  SX_PaymentCell.swift
//  ShixiUS
//
//  Created by heather on 2018/8/30.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  付款记录

import UIKit

class SX_PaymentCell: UITableViewCell {
    
    var payTitle : UILabel?
    var payDate  : UILabel?
    var payMoney : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension SX_PaymentCell {
    
    func ConfigCell() {
        
        self.payTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.height.equalTo(16.FloatValue.IPAD_XValue)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.font      = UIFont.boldSystemFont(ofSize: 15)
            TITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        })
        
        self.payDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.payTitle!.snp.bottom).offset(20.FloatValue.IPAD_XValue)
            make.left.equalTo(self.payTitle!)
            make.height.equalTo(13.FloatValue.IPAD_XValue)
        }).config({ (DATE) in
            DATE.sizeToFit()
            DATE.font      = UIFont.systemFont(ofSize: 12)
            DATE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
        
        self.payMoney = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.equalTo(self.payDate!)
            make.height.equalTo(Margin)
            make.right.equalTo(-20.FloatValue.IPAD_XValue)
        }).config({ (MONEY) in
            MONEY.sizeToFit()
            MONEY.textAlignment = .left
            MONEY.textColor     = UIColor.SX_MainColor()
            MONEY.font          = UIFont.systemFont(ofSize: 14)
        })
    }
}
