//
//  SX_VocationalTrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  职业培训  

import UIKit

class SX_VocationalTrainingCell: UITableViewCell {
    
    var vocationalTitle   : UILabel?
    var vocationalPeriod  : UILabel?  // 第一期 + 后面的时间
    var vocationalDate    : UILabel?
    
    var vocationalStyle   : UILabel?
    var vocationalContact : UILabel?  // 申请成功,等待客服联系
    var vocationalCancel  : UIButton?
    var vocationalPay     : UIButton?
    var vocationalRfund   : UIButton? // 退款

    
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
extension SX_VocationalTrainingCell {
    
    func ConfigCell() {
     
    }
    
  
    
    
    
    
    
}
