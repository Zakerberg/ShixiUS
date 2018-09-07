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
        
        
    }
}

