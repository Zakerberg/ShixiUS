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
            make.top.equalToSuperview().offset(Margin)
            make.left.width.height.equalToSuperview()
        }).config({ (projectBgView) in
            projectBgView.backgroundColor = UIColor.blue
            projectBgView.clipsToBounds = true
            //projectBgView.constraints = 10
        })
        
        self.projectName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.left.equalToSuperview().offset(Margin)
            make.width.equalToSuperview()
            make.height.equalTo(Margin+2)
        }).config({ (projectName) in
            projectName.font = UIFont.boldSystemFont(ofSize: 16)
            projectName.textColor = UIColor.black
        })
        
        self.projectContent = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectName!.snp.bottom).offset(Margin)
            make.left.width.equalTo(self.projectName!)
            make.height.equalTo(Margin-1)
        }).config({ (projectContent) in
            projectContent.textColor = UIColor.gray
            projectContent.font = UIFont.systemFont(ofSize: 14)
        })
        
        self.projectCity = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectContent!.snp.bottom).offset(Margin)
            make.left.equalTo(self.projectName!)
            make.width.equalTo(150)
        }).config({ (projectCity) in
            projectCity.textColor = UIColor.gray
            projectCity.font = UIFont.systemFont(ofSize: 13)
        })
        
        self.projectPrice = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectCity!.snp.bottom).offset(Margin)
            make.left.width.equalTo(self.projectName!)
        }).config({ (projectPrice) in
            projectPrice.font = UIFont.boldSystemFont(ofSize: 14)
            projectPrice.textColor = UIColor.red
        })
    }
}
