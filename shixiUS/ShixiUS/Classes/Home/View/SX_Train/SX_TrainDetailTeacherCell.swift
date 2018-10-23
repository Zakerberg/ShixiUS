//
//  SX_TrainDetailTeacherCell.swift
//  ShixiUS
//
//  Created by heather on 2018/10/23.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证里面的 老师 列表cell

/*
 在所有的情诗中我只写了其中最轻的一行
 在最轻的一行里
 我只写了你最轻的名字
 */

import UIKit

class SX_TrainDetailTeacherCell: UITableViewCell {
    
    var icon:UIImageView?
    var name:UILabel?
    /// 天津大学, 硕士, 注册会计师
    var edu:UILabel?
    var describe:UILabel?
    
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

// ===============================================================================
// MARK: - ConfigCell()
// ===============================================================================
extension SX_TrainDetailTeacherCell {
    func ConfigCell() {
        
        self.icon = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (ICON) in
            
        })
        
        self.name = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (NAME) in
            
        })
        
        self.edu = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (EDU) in
            
        })
        
        let line = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (LINE) in
            
        })
        
        self.describe = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (DESCRIBE) in
            
        })
    }
}
