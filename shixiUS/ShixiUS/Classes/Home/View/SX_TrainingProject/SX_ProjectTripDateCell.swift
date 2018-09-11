//
//  SX_ProjectTripDateCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/11.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情的 行程出发时间cell

import UIKit

class SX_ProjectTripDateCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// ==================================================================================================================
// MARK: - ConfigCell()
// =================================================================================================================
extension SX_ProjectTripDateCell {
  
    func ConfigCell() {
    
        
        
    }
}



