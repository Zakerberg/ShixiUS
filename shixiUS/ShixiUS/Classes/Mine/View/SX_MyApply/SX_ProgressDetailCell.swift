//
//  SX_ProgressDetailCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请进度详情Cell

import UIKit

class SX_ProgressDetailCell: UITableViewCell {
    
    var progressTitle   : UILabel?
    var progressDes     : UILabel? // 详情
    
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

// ======================================================================================================================
// MARK: - ConfigCell
// ======================================================================================================================
extension SX_ProgressDetailCell{
    
    func ConfigCell() {
        
        self.progressTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.left.equalToSuperview().offset(50.FloatValue.IPAD_XValue)
            make.height.equalTo(15.FloatValue.IPAD_XValue)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.font = UIFont.boldSystemFont(ofSize: 14)
        })
        
        self.progressDes = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.progressTitle!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.height.left.equalTo(self.progressTitle!)
            make.width.equalTo(250.FloatValue.IPAD_XValue)
        }).config({ (DES) in
            DES.sizeToFit()
            DES.numberOfLines = 0
            DES.lineBreakMode = .byWordWrapping
            DES.font = UIFont.systemFont(ofSize: 14)
        })
    }
}
