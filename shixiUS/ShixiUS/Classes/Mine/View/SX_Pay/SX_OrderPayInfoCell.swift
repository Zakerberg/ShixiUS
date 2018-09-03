//
//  SX_OrderPayInfoCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  订单详情页面 --- 支付信息 (0,1)

/*
 我生命中的千山万水,
 任你一一告别。
 世间事，除了生死，
 哪一件不是闲事。
   仓央嘉措
 */

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
            make.left.top.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (TRADINGSTATUS) in
            TRADINGSTATUS.sizeToFit()
            TRADINGSTATUS.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        })
        
        /// 付款(支付)时间
        self.payTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.tradingStauts!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.tradingStauts!)
            make.height.equalTo(15)
        }).config({ (PAYTIME) in
            PAYTIME.sizeToFit()
            PAYTIME.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            PAYTIME.font = UIFont.systemFont(ofSize: 15)
        })
        
        /// 订单(交易)号
        self.orderNum = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.payTime!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.tradingStauts!)
            make.height.equalTo(15)
        }).config({ (ORDERNUM) in
            ORDERNUM.sizeToFit()
            ORDERNUM.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            ORDERNUM.font = UIFont.systemFont(ofSize: 15)
        })
        
        /// 下单时间(交易方式)
        self.makeOrder = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderNum!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.tradingStauts!)
            make.height.equalTo(15)
        }).config({ (MAKEORDER) in
            MAKEORDER.sizeToFit()
            MAKEORDER.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            MAKEORDER.font = UIFont.systemFont(ofSize: 15)
        })
        
        /// 订单(支付)金额
        self.payPrice = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.makeOrder!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.tradingStauts!)
            make.height.equalTo(15)
        }).config({ (PAYPRICE) in
            PAYPRICE.sizeToFit()
            PAYPRICE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            PAYPRICE.font = UIFont.systemFont(ofSize: 15)
        })
    }
}
