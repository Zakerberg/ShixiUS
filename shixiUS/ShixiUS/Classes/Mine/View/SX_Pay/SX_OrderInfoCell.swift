//
//  SX_OrderInfoCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  订单详情页面 --- 订单信息

import UIKit

class SX_OrderInfoCell: UITableViewCell {
    
    var orderStatus : UILabel? /// 【已支付】
    var orderNum    : UILabel?
    var orderDate   : UILabel?
    
    var orderpojectImage       : UIImageView?
    var orderpojectTitle       : UILabel?
    var orderpojectDate        : UILabel?
    var orderpojectPeopleCount : UILabel?
    var orderpojectDestination : UILabel?
    
    var totalAmount   : UILabel?
    /// 应付金额
    var payableAmount : UILabel?
    
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

// ===========================================================================================================================
// MARK: - ConfigCell()
// ===========================================================================================================================
extension SX_OrderInfoCell {
    
    func ConfigCell() {
        
        self.orderStatus  = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ORDERSTATUS) in
            
        })
        
        self.orderNum = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ORDERNUM) in
            
        })
        
        self.orderDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ORDERDATE) in
            
        })
        
// ----------------------------------------------------------------------------------------------------------------------
        
        let line1 = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (LINE1) in
            
        })
        
        self.orderpojectImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ORDERMAGE) in
            
        })
        
        self.orderpojectTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ORDERTITLE) in
            
        })
        
        self.orderpojectDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (PROJECTFATE) in
            
        })
        
        self.orderpojectPeopleCount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (PEOPLECOUNT) in
            
        })
        
        self.orderpojectDestination = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (DESTINATION) in
            
        })
        
        let line2 = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (LINE2) in
            
        })
        
// --------------------------------------------------------------------------------------------------------------------------
        
        self.totalAmount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (TOTALAMOUNT) in
            
        })
        
        self.payableAmount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (PAYABLEAMOUNT) in
            
        })
    }
}





