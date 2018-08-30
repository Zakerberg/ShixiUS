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
            
        }).config({ (TITLE) in
            
        })
       
        self.payDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (DATE) in
            
        })
        
        self.payMoney = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (MONEY) in
            
        })
    }
}







