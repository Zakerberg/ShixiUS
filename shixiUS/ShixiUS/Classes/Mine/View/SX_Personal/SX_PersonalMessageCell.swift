//
//  SX_PersonalMessageCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/9/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息Cell

import UIKit

class SX_PersonalMessageCell: UITableViewCell {

    var titleLabel   : UILabel?
    var tF           : UITextField?
    
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
extension SX_PersonalMessageCell {
    
    func ConfigCell() {
        
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.width.equalTo(80.FloatValue.IPAD_XValue)
            make.height.equalTo(20.FloatValue.IPAD_XValue)
        }).config({ (Title) in
            Title.sizeToFit()
            Title.font = UIFont.systemFont(ofSize: 15)
            Title.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        })
        
        self.tF = UITextField().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.left.equalTo(self.titleLabel!.snp.right).offset(Margin)
            make.height.equalTo(40.FloatValue.IPAD_XValue)
        }).config({ (tF) in
            tF.placeholder = "请输入用户名 --- 测试"
            tF.textColor   = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
    }
}
