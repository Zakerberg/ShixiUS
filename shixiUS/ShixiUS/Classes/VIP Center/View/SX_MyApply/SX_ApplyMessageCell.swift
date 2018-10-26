//
//  SX_ApplyMessageCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/7.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请表里面的其他填写的信息

import UIKit

class SX_ApplyMessageCell: UITableViewCell {
    
    var title: UILabel?
    var TF: UITextField?
    
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
extension SX_ApplyMessageCell {
    
    func ConfigCell() {
        self.title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalToSuperview().offset(Margin)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            TITLE.font = UIFont.systemFont(ofSize: 14)
        })

        self.TF = UITextField().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.top.equalTo(self.title!)
            make.left.equalTo(self.title!.snp.right).offset(Margin)
        }).config({ (TF) in
           TF.sizeToFit()
            
        })
    }
}

