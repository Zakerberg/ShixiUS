//
//  SX_AddressPickViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/6.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 你的呼吸，是我心上的线
 牵引着我做任何事情
 你说爱我，我从此坠落在你怀里
 */

import UIKit

class SX_AddressPickViewCell: UITableViewCell {
    static let identifier = "SXAddressPickViewCell"
    
    let label: UILabel  = {
        let label       = UILabel(frame: CGRect(x: 42, y: 8, width: 200, height: 24))
        label.font      = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        drawMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===================================================================================================================
// MARK: - drawMyView()
// ===================================================================================================================
extension SX_AddressPickViewCell {
    private func drawMyView() {
        self.addSubview(label)
    }
}

class SX_AddressPickViewFirstCell: UITableViewCell {
    static let identifier = "SXAddressPickViewFirstCell"
    
    let label: UILabel  = {
        let label       = UILabel(frame: CGRect(x: 24, y: 11.5, width: 100, height: 17))
        label.font      = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        drawMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===================================================================================================================
// MARK: - drawMyView()
// ===================================================================================================================
extension SX_AddressPickViewFirstCell {
    private func drawMyView() {
        self.addSubview(label)
    }
}
