//
//  SX_MineIconViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_MineIconViewCell: UITableViewCell {

    var logInBtn: UIButton?
    var iconImageView: UIImageView?
    var nameTitle: UILabel?
//    var VIPImageView: UIImageView?
//    var VIPLabel: UILabel?
    
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
        
    }
}

// ===============================================================================================================================
// MARK: - configCell()
// ===============================================================================================================================
extension SX_MineIconViewCell {
    
    func configCell() {
        
        self.iconImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in

        }).config({ (iconImageView) in

        })

        self.logInBtn = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (logInBtn) in
            
        })
        
        self.nameTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (iconImageView) in
            
        })
    }
}
