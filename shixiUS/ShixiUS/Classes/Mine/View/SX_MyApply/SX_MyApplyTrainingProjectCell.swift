//
//  SX_MyApplyTrainingProjectCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ----> 实训项目cell

import UIKit

class SX_MyApplyTrainingProjectCell: UITableViewCell {
    
    var projectTitle     : UILabel?
    var projectAddress   : UILabel?
    var projectTime      : UILabel?
    var projectDate      : UILabel?
    var projectStyle     : UILabel?
    
    var projectContact   : UILabel?
    var projectCancel    : UIButton? // 取消申请
    var projectPay       : UIButton? // 支付
    var projectRefund    : UIButton? // 退款
    
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
extension SX_MyApplyTrainingProjectCell {
    func ConfigCell() {
        
        self.projectTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Title) in
            
        })
        
        let addressImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (addressImage) in
            
        })
        
        self.projectAddress = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Address) in
            
        })
        
        let timeImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (timeImage) in
            
        })
        
        self.projectTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Time) in
            
        })
        
        self.projectDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Date) in
            
        })
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (line) in
            
        })
        
// ---------------------------------------------------------------------------------------------------------------------------------
        
        self.projectStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Style) in
            
        })
        
        self.projectContact = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Contact) in
            
        })
        
        self.projectCancel = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Cancel) in
            
        })
        
        self.projectPay = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Pay) in
            
        })
        
        self.projectRefund = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Refund) in
            
        })
    }
}


