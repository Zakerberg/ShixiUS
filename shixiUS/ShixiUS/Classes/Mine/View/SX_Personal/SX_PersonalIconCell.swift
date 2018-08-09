//
//  SX_PersonalIconCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/9/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  

import UIKit

class SX_PersonalIconCell: UITableViewCell {
    
    var personIcon: UIImageView?
    
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
extension SX_PersonalIconCell {
    
    func ConfigCell() {
        
        self.personIcon = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-30.FloatValue.IPAD_XValue)
            make.height.width.equalTo(60.FloatValue.IPAD_XValue)
        }).config({ (iconImageView) in
            iconImageView.layer.masksToBounds = true
            iconImageView.layer.cornerRadius  = 30
            iconImageView.image = UIImage.init(named: "icon")
        })
    }
}
