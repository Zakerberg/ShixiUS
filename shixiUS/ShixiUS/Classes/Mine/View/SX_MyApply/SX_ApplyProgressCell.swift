//
//  SX_ApplyProgressCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请里面 所有的 申请进度Cell 申请详情里面的申请进度

import UIKit

class SX_ApplyProgressCell: UITableViewCell {

    /// 整个Cell的背景View 上面放 被驳回的Label
    var progressBgView   : UIView?

    var progressImageV   : UIImageView?
    var progressTitle    : UILabel?
    var progressTime     : UILabel?
    /// 退款申请被驳回Label
    var progressRejected : UILabel?
    /// 申请进度Btn >
    var progressBtn      : UIButton?

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

// =============================================================================================================
// MARK: - ConfigCell
//==============================================================================================================
extension SX_ApplyProgressCell {
    
    func ConfigCell() {
        
        progressBgView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.edges.equalToSuperview()
        }).config({ (BGVIEW) in
           BGVIEW.backgroundColor = UIColor.green
        })
        
        let title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.height.equalTo(16)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.text = "申请进度"
            TITLE.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            TITLE.font = UIFont.boldSystemFont(ofSize: 15)
        })
        
        self.progressImageV = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(title.snp.bottom)
            make.height.width.equalTo(Margin*2)
        }).config({ (IMAGEVIEW) in
            IMAGEVIEW.image = UIImage.init(named: "progress")
        })
        
        self.progressTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.progressImageV!)
            make
        }).config({ (PROGRESSTITLE) in
            PROGRESSTITLE
        })
     
        self.progressTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
            
        }).config({ (TIME) in
            
            
        })
        
        /// 驳回!
        self.progressRejected = UILabel().addhere(toSuperView: self.progressBgView!).layout(snapKitMaker: { (make) in
            
            
        }).config({ (REJECTED) in
            
            
        })
    }
}
