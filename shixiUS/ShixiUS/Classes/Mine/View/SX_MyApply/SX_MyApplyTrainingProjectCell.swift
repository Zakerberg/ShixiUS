//
//  SX_MyApplyTrainingProjectCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ----> 实训项目cell

import UIKit

class SX_MyApplyTrainingProjectCell: UITableViewCell {
    
    var projectTitle        : UILabel?
    var projectAddress      : UILabel?
    var projectTime         : UILabel?
    var projectDate         : UILabel?
    var projectStyle        : UILabel?
    
    /// 等待客服联系
    var projectContact      : UILabel?
    
    /// 取消申请
    var projectCancel       : SX_UnderlineBtn?
    /// 支付 && 退款
    var projectPayAndRefund : UIButton?
    
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

// =======================================================================================================================
// MARK: - ConfigCell
// =======================================================================================================================
extension SX_MyApplyTrainingProjectCell {
    func ConfigCell() {
        
        self.projectTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            TITLE.font = UIFont.boldSystemFont(ofSize: 15)
        })
        
        let addressImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectTitle!.snp.bottom).offset(Margin)
            make.left.equalTo(self.projectTitle!)
            make.height.width.equalTo(11.FloatValue.IPAD_XValue)
        }).config({ (ADDRESSIMAGEV) in
            ADDRESSIMAGEV.image = #imageLiteral(resourceName: "address")
        })
        
        self.projectAddress = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.left.equalTo(addressImage.snp.right).offset(2.FloatValue.IPAD_XValue)
        }).config({ (ADDRESS) in
            ADDRESS.sizeToFit()
            ADDRESS.font = UIFont.systemFont(ofSize: 11)
            ADDRESS.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        let timeImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.left.equalTo(self.projectAddress!.snp.right).offset(Margin)
        }).config({ (TIMEIMAGE) in
            TIMEIMAGE.image = #imageLiteral(resourceName: "Apply_Time")
        })

        self.projectTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.left.equalTo(timeImage.snp.right).offset(2.FloatValue.IPAD_XValue)
        }).config({ (TIME) in
            TIME.sizeToFit()
            TIME.font = UIFont.systemFont(ofSize: 11)
            TIME.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })

        self.projectDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (DATE) in
            DATE.sizeToFit()
            DATE.font = UIFont.systemFont(ofSize: 11)
            DATE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })

        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectAddress!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(addressImage)
            make.right.equalTo(self.projectDate!)
            make.height.equalTo(0.5)
        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })
        
// ---------------------------------------------------------------------------------------------------------------------------
        
//        self.projectStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//
//        }).config({ (Style) in
//
//        })
//
//        self.projectContact = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//
//        }).config({ (Contact) in
//
//        })
//
//        self.projectCancel = SX_UnderlineBtn(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//
//        }).config({ (Cancel) in
//
//        })
//
//        self.projectPayAndRefund = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//
//        }).config({ (Pay) in
//
//        })
    }
}


