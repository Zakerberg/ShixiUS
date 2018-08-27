//
//  SX_ProgressDetailCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请进度详情Cell

import UIKit

class SX_ProgressDetailCell: UITableViewCell {

    var progressTitle : UILabel?
    var progressDes   : UILabel?
    var progressDate  : UILabel?
    
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

// ======================================================================================================================
// MARK: - ConfigCell
// ======================================================================================================================
extension SX_ProgressDetailCell{
    
    func ConfigCell() {
        
        self.progressTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (TITLE) in
            
        })
        
        self.progressDes = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (TITLE) in
            
        })
        
        self.progressDate = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (TITLE) in
            
        })
    }
}
