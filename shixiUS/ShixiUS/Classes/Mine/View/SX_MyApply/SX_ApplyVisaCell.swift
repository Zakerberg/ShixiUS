//
//  SX_ApplyVisaCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/6.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请表里面的 (是否有签证 & 是否在校)

/*
 南风起
 南风和着微光
 掀起你的发梢，拂过你的脸庞
 最后，穿过我的胸膛
 */

import UIKit

class SX_ApplyVisaCell: UITableViewCell {

    var title: UILabel?
    var btn: UIButton?
    
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

// ===================================================================================================================
// MARK: - ConfigCell()
// ===================================================================================================================
extension SX_ApplyVisaCell {
    
    func ConfigCell() {
        
        self.title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.height.equalTo(15)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            TITLE.font = UIFont.systemFont(ofSize: 14)
        })

        
        
        
        
        
    }
}








