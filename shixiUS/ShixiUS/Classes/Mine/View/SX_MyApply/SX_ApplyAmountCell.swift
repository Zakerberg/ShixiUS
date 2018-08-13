//
//  SX_ApplyAmountCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请里面 所有的 申请金额Cell

import UIKit

class SX_ApplyAmountCell: UITableViewCell {

    /// 岗位 && 状态
    var amountTitle  : UILabel?
    /// 金额
    var amountNumber : UILabel?
    
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
extension SX_ApplyAmountCell {
    
    func ConfigCell() {
     
        self.amountTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Title) in
            
        })
        
        self.amountNumber = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (Title) in
            
        })
    }
}
