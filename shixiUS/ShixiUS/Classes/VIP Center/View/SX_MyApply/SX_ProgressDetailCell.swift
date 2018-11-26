//
//  SX_ProgressDetailCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请进度详情Cell

/*
 无论世界多污秽
 有多少虚伪不纯粹
 都有我在你身边
 拼死给你一方碧海蓝天
 */

import UIKit

class SX_ProgressDetailCell: UITableViewCell {
    
    var progressPoint: UIImageView?
    var steps: UILabel?
    var stepsCn: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //   ConfigCell()
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

// ========================================================================
// MARK: - ConfigCell
// ========================================================================
extension SX_ProgressDetailCell{
    
    func ConfigCell() {
        self.progressPoint = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.width.height.equalTo(Margin)
        }).config({ (POINT) in
            POINT.sizeToFit()
        })
        
        self.steps = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.equalTo(self.progressPoint!)
            make.left.equalTo(self.progressPoint!.snp.right).offset(Margin)
            make.height.equalTo(15.FloatValue.IPAD_XValue)
        }).config({ (STEPS) in
            STEPS.sizeToFit()
            STEPS.font = UIFont.boldSystemFont(ofSize: 15)
        })
        
        self.stepsCn = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.steps!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.steps!)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (STEPSCN) in
            STEPSCN.sizeToFit()
            STEPSCN.numberOfLines = 0
            STEPSCN.lineBreakMode = .byWordWrapping
            STEPSCN.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            STEPSCN.font          = UIFont.systemFont(ofSize: 14)
        })
        
         _ = UIView().addhere(toSuperView: self.contentView).layout { (make) in
            make.top.equalTo(self.stepsCn!.snp.bottom).offset(Margin)
            make.left.right.equalTo(self.stepsCn!)
            make.height.equalTo(0.5)
            }.config { (LINE) in
                LINE.backgroundColor = UIColor.colorWithHexString(hex: "f0f0f0", alpha: 1)
        }
    }
}
