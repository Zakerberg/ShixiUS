//
//  SX_OrderInfoCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  订单详情页面 --- 订单信息

import UIKit

class SX_OrderInfoCell: UITableViewCell {

    var orderStatus : UILabel?
    var orderNum    : UILabel?
    var orderDate   : UILabel?
    
    var orderpojectImage: UIImageView?
    var orderpojectTitle: UILabel?
    var orderpojectDate: UILabel?
    var orderpojectPeopleCount : UILabel?
    var orderpojectDestination : UILabel?
    
    var totalAmount   : UILabel?
    /// 应付金额
    var payableAmount : UILabel?
    
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


// ===========================================================================================================================
// MARK: - ConfigCell()
// ===========================================================================================================================
extension SX_OrderInfoCell {
    
    func ConfigCell() {
        
        
    }
}



