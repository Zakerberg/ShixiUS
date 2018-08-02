//
//  SX_ProjectDetailCostInformationCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/1/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情 -- 项目费用 && 预定须知Cell

import UIKit

class SX_ProjectDetailCostInformationCell: UITableViewCell {

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
// MARK: - ConfigCell()
// ===============================================================================================================================
extension SX_ProjectDetailCostInformationCell {
    
    func ConfigCell() {
        
    }
}
