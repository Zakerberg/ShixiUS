//
//  SX_ApplyProgressCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请里面 所有的 申请进度Cell

import UIKit

class SX_ApplyProgressCell: UITableViewCell {

    /// 整个Cell的背景View 上面放 被驳回的Label
    var progressBgView   : UIView?

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

// ===============================================================================================================================
// MARK: - ConfigCell
// ===============================================================================================================================
extension SX_ApplyProgressCell {
    
    func ConfigCell() {
        
        progressBgView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.edges.equalToSuperview()
        }).config({ (bgView) in
           bgView.backgroundColor = UIColor.green
        })
        
        let title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (title) in
            title.text = "申请进度"
            title.sizeToFit()
            title.font = UIFont.boldSystemFont(ofSize: 15)
        })
        
        self.progressTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Title) in
            
        })
     
        self.progressTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Time) in
            
        })
        
        self.progressRejected = UILabel().addhere(toSuperView: self.progressBgView!).layout(snapKitMaker: { (make) in
            
        }).config({ (Title) in
            
        })
    }
}
