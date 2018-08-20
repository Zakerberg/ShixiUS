//
//  SX_OrderPayInfoCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  订单详情页面 --- 支付信息 (0,1)

import UIKit

class SX_OrderPayInfoCell: UITableViewCell {
    
    /// 交易状态(支付信息)
    var tradingStauts : UILabel?
    /// 付款(支付)时间
    var payTime       : UILabel?
    /// 订单(交易)号
    var orderNum      : UILabel?
    /// 下单时间(交易方式)
    var makeOrder     : UILabel?
    /// 订单(支付)金额
    var payPrice      : UILabel?
    
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
extension SX_OrderPayInfoCell {
    
    func ConfigCell() {
        
        /// 交易状态(支付信息)
        self.tradingStauts = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (TRADINGSTATUS) in
            
        })
        
        /// 付款(支付)时间
        self.payTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (PAYTIME) in
            
        })
        
        /// 订单(交易)号
        self.orderNum = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ORDERNUM) in
            
        })
        
        /// 下单时间(交易方式)
        self.makeOrder = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (MAKEORDER) in
            
        })
        
        /// 订单(支付)金额
        self.payPrice = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (PAYPRICE) in
            
        })
    }
}







