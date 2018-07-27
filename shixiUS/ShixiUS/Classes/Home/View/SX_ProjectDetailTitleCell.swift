//
//  SX_ProjectDetailTitleCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/27/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情 title Cell

import UIKit

class SX_ProjectDetailTitleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// =================================================================================================================================
// MARK: - configCell()
// =================================================================================================================================
extension SX_ProjectDetailTitleCell {
    
    func configCell() {
        
        
    }
}





