//
//  SX_PersonalHeadPortraitCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/12.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息里面头像Cell

import UIKit

class SX_PersonalHeadPortraitCell: UITableViewCell {

    var headPortraitImageV: UIImageView?
    var titleLabel:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

// ====================================================================
// MARK: - ConfigCell()
// ====================================================================
extension SX_PersonalHeadPortraitCell {
    
    func ConfigCell() {
     
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalToSuperview().offset(Margin)
            make.centerY.equalToSuperview()
            make.width.equalTo(80.FloatValue.IPAD_XValue)
            make.height.equalTo(20.FloatValue.IPAD_XValue)
        }).config({ (Title) in
            Title.sizeToFit()
            Title.font = UIFont.systemFont(ofSize: 15)
            Title.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        })
        
        self.headPortraitImageV = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30.FloatValue.IPAD_XValue)
            make.width.height.equalTo(60.FloatValue.IPAD_XValue)
        }).config({ (HEAD) in
            HEAD.image = #imageLiteral(resourceName: "icon")
            HEAD.layer.masksToBounds = true
            HEAD.layer.cornerRadius  = 30
            HEAD.isUserInteractionEnabled = true
        })
    }
}
