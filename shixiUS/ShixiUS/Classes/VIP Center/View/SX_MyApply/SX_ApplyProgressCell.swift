//
//  SX_ApplyProgressCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请里面 所有的 申请进度Cell 申请详情里面的申请进度

/*
 我一直在这里
 等风 等雨
 更等你
 */

import UIKit

class SX_ApplyProgressCell: UITableViewCell {
    
    /// 背景View 上面放 被驳回的Label
    var progressBgView       : UIView?
    
    /// 背景View 上面放 正常的信息
    var progressNormalBgView : UIView?
    var progressStep         : UILabel?
    var progressStatus       : UILabel?
    /// 退款申请被驳回Label
    var progressRejected     : UILabel?
    /// 申请进度Btn >
    var progressBtn          : UIButton?
    
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

// ========================================================================
// MARK: - ConfigCell
// ========================================================================
extension SX_ApplyProgressCell {
    
    func ConfigCell() {
        
        // 驳回
        progressBgView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.edges.equalToSuperview()
        }).config({ (BGVIEW) in
            BGVIEW.backgroundColor = UIColor.white
        })
        
        // Normal
        self.progressNormalBgView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.edges.equalToSuperview()
        }).config({ (NORMAL) in
            NORMAL.backgroundColor = UIColor.white
        })
        
        let title = UILabel().addhere(toSuperView: self.progressNormalBgView!).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.text      = "申请进度"
            TITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            TITLE.font      = UIFont.boldSystemFont(ofSize: 15)
        })
        
        let progressImageV = UIImageView().addhere(toSuperView: self.progressNormalBgView!).layout(snapKitMaker: { (make) in
            make.top.equalTo(title.snp.bottom).offset(Margin)
            make.height.width.equalTo(Margin)
            make.left.equalTo(title)
        }).config({ (IMAGEVIEW) in
            IMAGEVIEW.image = UIImage.init(named: "progress")
        })
        
        self.progressStep = UILabel().addhere(toSuperView: self.progressNormalBgView!).layout(snapKitMaker: { (make) in
            make.centerY.equalTo(progressImageV)
            make.left.equalTo(progressImageV.snp.right).offset(Margin)
        }).config({ (STEP) in
            STEP.sizeToFit()
            STEP.font      = UIFont.systemFont(ofSize: 15)
            STEP.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
        })
        
        self.progressStatus = UILabel().addhere(toSuperView: self.progressNormalBgView!).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.progressStep!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(progressImageV.snp.right).offset(Margin)
            make.width.equalTo(250.FloatValue.IPAD_XValue)
        }).config({ (STATUS) in
            STATUS.sizeToFit()
            STATUS.numberOfLines = 0
            STATUS.lineBreakMode = .byWordWrapping
            STATUS.font          = UIFont.systemFont(ofSize: 14)
            STATUS.textColor     = UIColor.colorWithRGB(r: 102, g: 153, b: 0)
        })
        
        let _ = UIView().addhere(toSuperView: self.progressNormalBgView!).layout { (make) in
            make.top.equalTo(progressImageV.snp.bottom)
            make.centerX.equalTo(progressImageV)
            make.width.equalTo(1)
            make.height.equalTo(self.progressStatus!).offset(-Margin)
            }.config { (LINEVIEW) in
                //   LINEVIEW.setGradientBackgroundWith([UIColor.gray, UIColor.white], locations: nil, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 1, y: 0))
        }
        
        /// 驳回!
        self.progressRejected = UILabel().addhere(toSuperView: self.progressBgView!).layout(snapKitMaker: { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(20)
        }).config({ (REJECTED) in
            REJECTED.sizeToFit()
            REJECTED.textColor = UIColor.red
            REJECTED.font      = UIFont.boldSystemFont(ofSize: 18)
        })
    }
}
