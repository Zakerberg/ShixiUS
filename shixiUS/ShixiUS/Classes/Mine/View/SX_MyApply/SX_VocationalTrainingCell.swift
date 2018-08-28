//
//  SX_VocationalTrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ---> 职业培训

/*
 我爱你
 可最后我们都要长大
 从满腔热血变成满头白发
 终将有晚辈再出发
 不求陪你仗剑天涯
 可绝不在你启程时勒住你的马
 */

import UIKit

class SX_VocationalTrainingCell: UITableViewCell {
    
    var vocationalTitle        : UILabel?
    
    /// 第一期 + 后面的时间
    var vocationalPeriod       : UILabel?
    var vocationalDate         : UILabel?
    
    /// 申请成功
    var vocationalStyle        : UILabel?
    /// 等待客服联系
    var vocationalContact      : UILabel?
    var vocationalCancel       : SX_UnderlineBtn?
    var vocationalPayAndRefund : UIButton?
    
    
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

// ==========================================================================================================
// MARK: - ConfigCell
// ===========================================================================================================
extension SX_VocationalTrainingCell {
    
    func ConfigCell() {
        
        self.vocationalTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            TITLE.font = UIFont.boldSystemFont(ofSize: 15)
        })
        
        let periodImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.vocationalTitle!.snp.bottom).offset(Margin)
            make.left.equalTo(self.vocationalTitle!)
            make.height.width.equalTo(11.FloatValue.IPAD_XValue)
        }).config({ (PERIODIMAGE) in
            PERIODIMAGE.image = #imageLiteral(resourceName: "Apply_ClassTime")
        })
        
        self.vocationalPeriod = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(periodImage)
            make.left.equalTo(periodImage.snp.right).offset(2.FloatValue.IPAD_XValue)
        }).config({ (PEROID) in
            PEROID.sizeToFit()
            PEROID.font = UIFont.systemFont(ofSize: 11)
            PEROID.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        self.vocationalDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(periodImage)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (DATE) in
            DATE.sizeToFit()
            DATE.font = UIFont.systemFont(ofSize: 11)
            DATE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.vocationalPeriod!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(periodImage)
            make.right.equalTo(self.vocationalDate!)
            make.height.equalTo(0.5)
        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })
        
//--------------------------------------------------------------------------------------------------------------------------
        
        self.vocationalStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(Margin)
            make.left.equalTo(self.vocationalTitle!)
            make.height.equalTo(13)
        }).config({ (STYLE) in
            STYLE.sizeToFit()
            STYLE.font = UIFont.systemFont(ofSize: 12)
            STYLE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
        
        self.vocationalContact = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(13)
        }).config({ (CONTACT) in
            CONTACT.sizeToFit()
            CONTACT.font = UIFont.systemFont(ofSize: 12)
            CONTACT.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })
        
        self.vocationalPayAndRefund = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(25.FloatValue.IPAD_XValue)
            make.width.equalTo(80.FloatValue.IPAD_XValue)
        }).config({ (Pay) in
            
        })
        
        self.vocationalCancel = SX_UnderlineBtn(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(25.FloatValue.IPAD_XValue)
            make.width.equalTo(80.FloatValue.IPAD_XValue)
        }).config({ (Cancel) in
            
        })
    }
}
