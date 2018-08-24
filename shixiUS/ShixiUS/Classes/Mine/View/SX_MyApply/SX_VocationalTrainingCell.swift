//
//  SX_VocationalTrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ---> 职业培训

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
            
        }).config({ (Title) in
            
        })
        
        let periodImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (periodImage) in
            
        })
        
        self.vocationalPeriod = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Period) in
            
        })
        
        self.vocationalDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Date) in
            
        })
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (line) in
            
        })
        
//--------------------------------------------------------------------------------------------------------------------------
        
        self.vocationalStyle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Style) in
            
        })
        
        self.vocationalContact = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Contact) in
            
        })
        
        self.vocationalPayAndRefund = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Pay) in
            
        })
        
        self.vocationalCancel = SX_UnderlineBtn(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Cancel) in
            
        })

    }
}
