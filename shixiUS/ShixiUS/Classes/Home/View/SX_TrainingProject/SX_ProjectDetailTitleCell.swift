//
//  SX_ProjectDetailTitleCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/27/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情 title Cell

import UIKit

class SX_ProjectDetailTitleCell: UITableViewCell {
    
    var projectBgView  : UIView?
    var projectName    : UILabel?
    var projectContent : UILabel?
    var projectCity    : UILabel?
    var projectPrice   : UILabel?
    
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
        
        self.projectBgView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (projectBgView) in
            
        })
        
        self.projectName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (projectName) in
            
        })
        
        self.projectContent = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (projectContent) in
            
        })
        
        self.projectCity = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (projectCity) in
            
        })
        
        self.projectPrice = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (projectPrice) in
            
        })
    }
}





