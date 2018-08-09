//
//  SX_PersonalMessageCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/9/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息Cell

import UIKit

class SX_PersonalMessageCell: UITableViewCell {

    var tF           : UITextField?
    var countryLabel : UILabel?
    
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
        
        self.tF = UITextField().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        
        }).config({ (tF) in

        })
        
        self.countryLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (countryL) in
            
        })
    }
}
