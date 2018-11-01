//
//  SX_ApplyDetailMessageCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/11/1.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_ApplyDetailMessageCell: UITableViewCell {
    
    var title: UILabel?
//    var depositBtn: UIButton?
    var price: UILabel?
    
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
extension SX_ApplyDetailMessageCell {
    
    func ConfigCell() {
        self.title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalToSuperview().offset(Margin)
            make.centerY.equalToSuperview()
            make.height.equalTo(Margin)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            TITLE.font      = UIFont.systemFont(ofSize: 14)
        })
        
//        self.depositBtn = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.height.centerY.equalTo(self.title!)
//            make.right.equalToSuperview().offset(-Margin)
//        }).config({ (DEPOSIT) in
//            DEPOSIT.sizeToFit()
//        })
        
        self.price = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.equalTo(self.title!)
            make.height.equalTo(20.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (PRICE) in
            PRICE.sizeToFit()
        })
    }
}
