//
//  SX_OrderInfoCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  订单详情页面 --- 订单信息

/*
 假如真有来世，
 我愿生生世世为人，只做芸芸众生中的一个，
 哪怕一生贫困清苦，浪迹天涯，只要能爱恨歌哭，只要能心遂所愿。
   仓央嘉措
 */

import UIKit

class SX_OrderInfoCell: UITableViewCell {
    
    /// 【已支付】
    var orderStatus : UILabel?
    var orderNum    : UILabel?
    var orderDate   : UILabel?
    
    var orderpojectImage       : UIImageView?
    var orderpojectTitle       : UILabel?
    var orderpojectDate        : UILabel?
    var orderTrip              : UILabel?
    var orderPeopleCount       : UILabel?
    var orderDestination       : UILabel?
    
    var totalAmount            : UILabel?
    /// 应付金额
    var payableAmount          : UILabel?
    
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
        
        /// 订单信息
        let orderInfo = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (ORDERINFO) in
            ORDERINFO.sizeToFit()
            ORDERINFO.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            ORDERINFO.text      = "支付信息"
        })
        
        ///【已支付】
        self.orderStatus  = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(orderInfo.snp.bottom).offset(Margin*2)
            make.left.equalToSuperview().offset(6.FloatValue.IPAD_XValue)
            make.height.equalTo(15)
        }).config({ (ORDERSTATUS) in
            ORDERSTATUS.sizeToFit()
            ORDERSTATUS.font = UIFont.systemFont(ofSize: 15)
            ORDERSTATUS.textColor = UIColor.colorWithHexString(hex: "48a848", alpha: 1)
        })
        
        /// 订单号
        self.orderNum = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(self.orderStatus!)
            make.left.equalTo(self.orderStatus!.snp.right)
        }).config({ (ORDERNUM) in
            ORDERNUM.sizeToFit()
            ORDERNUM.font = UIFont.systemFont(ofSize: 15)
            ORDERNUM.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        })
        
        self.orderDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.right.equalToSuperview().offset(-10.FloatValue.IPAD_XValue)
            make.height.equalTo(12)
            make.centerY.equalTo(self.orderNum!)
        }).config({ (ORDERDATE) in
            ORDERDATE.sizeToFit()
            ORDERDATE.font = UIFont.systemFont(ofSize: 12)
            ORDERDATE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
    
// ----------------------------------------------------------------------------------------------------------------------
        
        let line1 = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderStatus!.snp.bottom).offset(12)
            make.left.equalTo(self.orderStatus!)
            make.right.equalTo(self.orderDate!)
            make.height.equalTo(0.5)
        }).config({ (LINE1) in
            LINE1.backgroundColor = UIColor.lightGray
        })
        
        //  218 120
        self.orderpojectImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(line1.snp.bottom).offset(Margin)
            make.left.equalToSuperview().offset(Margin)
            make.height.equalTo(60.FloatValue.IPAD_XValue)
            make.width.equalTo(109.FloatValue.IPAD_XValue)
        }).config({ (ORDERIMAGE) in
            ORDERIMAGE.layer.masksToBounds = true
            ORDERIMAGE.layer.cornerRadius = 6
        })
        
        self.orderpojectTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderpojectImage!)
            make.left.equalTo(self.orderpojectImage!.snp.right).offset(5.FloatValue.IPAD_XValue)
            make.height.equalTo(13)
        }).config({ (ORDERTITLE) in
            ORDERTITLE.sizeToFit()
            ORDERTITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            ORDERTITLE.font = UIFont.boldSystemFont(ofSize: 13)
        })
        
        self.orderTrip = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderpojectTitle!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.orderpojectTitle!)
            make.height.equalTo(11)
        }).config({ (TRIP) in
            TRIP.sizeToFit()
            TRIP.font = UIFont.systemFont(ofSize: 12)
            TRIP.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
        
        self.orderPeopleCount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderTrip!)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(12.FloatValue.IPAD_XValue)
        }).config({ (PEOPLECOUNT) in
            PEOPLECOUNT.sizeToFit()
            PEOPLECOUNT.textAlignment = .left
            PEOPLECOUNT.font = UIFont.systemFont(ofSize: 12)
            PEOPLECOUNT.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        })
        
        self.orderpojectDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderTrip!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.orderpojectTitle!)
            make.height.equalTo(11)
        }).config({ (PROJECTDATE) in
            PROJECTDATE.sizeToFit()
            PROJECTDATE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            PROJECTDATE.font = UIFont.systemFont(ofSize: 12)
        })

        self.orderDestination = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderpojectDate!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.orderpojectTitle!)
            make.height.equalTo(11)
        }).config({ (DESTINATION) in
            DESTINATION.sizeToFit()
            DESTINATION.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            DESTINATION.font = UIFont.systemFont(ofSize: 12)
        })
        
        let line2 = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.orderpojectImage!.snp.bottom).offset(Margin)
            make.left.equalTo(self.orderStatus!)
            make.right.equalTo(self.orderDate!)
            make.height.equalTo(0.5)
        }).config({ (LINE2) in
            LINE2.backgroundColor = UIColor.lightGray
        })
        
// --------------------------------------------------------------------------------------------------------------------------
        
        self.totalAmount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(line2.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin*2)
            make.height.equalTo(15)
        }).config({ (TOTALAMOUNT) in
            TOTALAMOUNT.sizeToFit()
            TOTALAMOUNT.font = UIFont.systemFont(ofSize: 12)
            TOTALAMOUNT.textAlignment = .left
            TOTALAMOUNT.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
        
        self.payableAmount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.totalAmount!.snp.bottom).offset(8.FloatValue.IPAD_XValue)
            make.right.height.equalTo(self.totalAmount!)
        }).config({ (PAYABLEAMOUNT) in
            PAYABLEAMOUNT.sizeToFit()
            PAYABLEAMOUNT.font = UIFont.systemFont(ofSize: 15)
            PAYABLEAMOUNT.textAlignment = .left
            PAYABLEAMOUNT.textColor = UIColor.red
        })
    }
}

