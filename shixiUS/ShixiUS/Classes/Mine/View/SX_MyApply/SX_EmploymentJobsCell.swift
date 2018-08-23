//
//  SX_EmploymentJobsCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ----> 就业岗位Cell

import UIKit

class SX_EmploymentJobsCell: UITableViewCell {
    
    var employmentTitle     : UILabel?
    var employmentAddress   : UILabel?
    var employmentNature    : UILabel?
    var employmentDate      : UILabel?
    
    /// 岗位申请的状态
    var employmentStyle     : UILabel?
    
    /// 查看详情,取消申请, 面试通知, 录用通知, 退款
    var employmentDetail    : UIButton?
    /// 支付定金
    var employmentPay    : UIButton?
    
    
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

// ====================================================================================================================
// MARK: - ConfigCell
// ====================================================================================================================
extension SX_EmploymentJobsCell {
    
    func ConfigCell() {
        
        self.employmentTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            TITLE.font = UIFont.boldSystemFont(ofSize: 15)
        })
        
        let addressImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.employmentTitle!.snp.bottom).offset(Margin)
            make.left.equalTo(self.employmentTitle!)
            make.height.width.equalTo(11.FloatValue.IPAD_XValue)
        }).config({ (ADDRESSIMAGEV) in
            ADDRESSIMAGEV.image = #imageLiteral(resourceName: "address")
        })
        
        self.employmentAddress = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.left.equalTo(addressImage.snp.right).offset(2.FloatValue.IPAD_XValue)
        }).config({ (ADDRESS) in
            ADDRESS.sizeToFit()
            ADDRESS.font = UIFont.systemFont(ofSize: 11)
            ADDRESS.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        let natureImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.left.equalTo(self.employmentAddress!.snp.right).offset(Margin)
        }).config({ (NATUREIMAGE) in
            NATUREIMAGE.image = #imageLiteral(resourceName: "nature")
        })

        self.employmentNature = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.left.equalTo(natureImage.snp.right).offset(2.FloatValue.IPAD_XValue)
        }).config({ (NATURE) in
            NATURE.sizeToFit()
            NATURE.font = UIFont.systemFont(ofSize: 11)
            NATURE.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })

        self.employmentDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImage)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (DATE) in
            DATE.sizeToFit()
            DATE.font = UIFont.systemFont(ofSize: 11)
            DATE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })

        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.employmentAddress!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(addressImage)
            make.right.equalTo(self.employmentDate!)
            make.height.equalTo(0.5)
        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })
        
// ---------------------------------------------------------------------------------------------------------------------
        
        self.employmentStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(Margin)
            make.left.equalTo(self.employmentTitle!)
            make.height.equalTo(13)
        }).config({ (STYLE) in
            STYLE.sizeToFit()
            STYLE.font = UIFont.systemFont(ofSize: 12)
            STYLE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        })

        self.employmentDetail = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in

        }).config({ (DRTAIL) in

        })

        self.employmentPay = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in

        }).config({ (PAY) in

        })
    }
}
