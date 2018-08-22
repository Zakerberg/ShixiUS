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
    /// 岗位性质
    var employmentDate      : UILabel?
    /// 岗位申请的状态
    var employmentStyle     : UILabel?
    /// 查看详情
    var employmentDetail    : UIButton?
    /// 取消申请
    var employmentCancel    : UIButton?
    /// 支付定金
    var employmentDeposit   : UIButton?
    /// 面试通知
    var employmentInterview : UIButton?
    /// 录用通知
    var employmentEmployed  : UIButton?
    /// 退款
    var employmentRefund    : UIButton?
    
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
            
        }).config({ (ADDRESS) in
            
        })
        
        let natureImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (NATUREIMAGE) in
            
        })
        
        self.employmentNature = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (NATURE) in
            
        })
        
        self.employmentDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (DATE) in
            
        })
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (LINE) in
            
        })
        
// ---------------------------------------------------------------------------------------------------------------------
        
        self.employmentStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (STYLE) in
            
        })
        
        self.employmentDetail = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (DRTAIL) in
            
        })
        
        self.employmentCancel = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (CANCEL) in
            
        })
        
        self.employmentDeposit = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (DEPOSIT) in
            
        })
        
        self.employmentInterview = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (INTERVIEW) in
            
        })
        
        self.employmentEmployed = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (EMPLOYED) in
            
        })
        
        self.employmentRefund = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (REFUND) in
            
        })
    }
}
