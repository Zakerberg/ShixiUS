//
//  SX_ApplyAddressCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/6.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请表里面的 (国家 & 地址) 选择

/*
 幸运
 我也暗自欢喜
 原来曾经以为的遥不可及
 也不过两趟火车加一趟高铁的距离
 */

import UIKit

class SX_ApplyAddressCell: UITableViewCell {
    
    var title: UILabel?
    var addressBtn: UIButton?
    
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
// MARK: - ConfigCell
// ===================================================================================================================
extension SX_ApplyAddressCell {
    
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
        
        self.addressBtn = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.height.equalTo(self.title!)
            make.left.equalTo(self.title!.snp.right).offset(Margin)
        }).config({ (ADDRESS) in
            ADDRESS.sizeToFit()
            ADDRESS.setTitle("请选择", for: .normal)
            ADDRESS.setImage(UIImage.init(named: "Apply_arrow"), for: .normal)
            ADDRESS.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            ADDRESS.setTitleColor(UIColor.colorWithRGB(r: 204, g: 204, b: 204), for: .normal)
            ADDRESS.titleEdgeInsets = UIEdgeInsetsMake(0, -ADDRESS.imageView!.bounds.size.width, 0, ADDRESS.imageView!.bounds.size.width)
            ADDRESS.imageEdgeInsets = UIEdgeInsetsMake(0, ADDRESS.titleLabel!.bounds.size.width, 0, -ADDRESS.titleLabel!.bounds.size.width)
        })
    }
}

