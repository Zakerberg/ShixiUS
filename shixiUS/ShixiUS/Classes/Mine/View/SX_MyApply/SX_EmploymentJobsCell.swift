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
    var employmentNature    : UILabel?  // 岗位性质
    var employmentDate      : UILabel?
    
    var employmentStyle     : UILabel?  // 岗位申请的状态
    var employmentDetail    : UIButton? // 查看详情
    var employmentCancel    : UIButton? // 取消申请
    var employmentDeposit   : UIButton? // 支付定金
    var employmentInterview : UIButton? // 面试通知
    var employmentEmployed  : UIButton? // 录用通知
    var employmentRefund    : UIButton? // 退款
    
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

// ===============================================================================================================================
// MARK: - ConfigCell
// ===============================================================================================================================
extension SX_EmploymentJobsCell {
    
    func ConfigCell() {
        
        self.employmentTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Title) in
            
        })
        
        let addressImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (addressImage) in
            
        })
        
        self.employmentAddress = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Address) in
            
        })
        
        let natureImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (natureImage) in
            
        })
        
        self.employmentNature = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Nature) in
            
        })
        
        self.employmentDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Date) in
            
        })
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (line) in
            
        })
        
// ---------------------------------------------------------------------------------------------------------------------------------
        
        self.employmentStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (title) in
            
        })
        
        self.employmentDetail = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Detail) in
            
        })
        
        self.employmentCancel = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Cancel) in
            
        })
        
        self.employmentDeposit = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Deposit) in
            
        })
        
        
        self.employmentInterview = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Interview) in
            
        })
        
        self.employmentEmployed = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Employed) in
            
        })
        
        self.employmentRefund = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Refund) in
            
        })
    }
}



