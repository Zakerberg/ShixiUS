//
//  SX_UsInOverseaCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/24/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业里面的关于我们, 我们的服务,宗旨cell

import UIKit

class SX_UsInOverseaCell: UITableViewCell {
    
    var titleLabel : UILabel?
    var contentTF  : UITextView?
    
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

// ==================================================================================================================================
// MARK: - configCell
// ==================================================================================================================================
extension SX_UsInOverseaCell {
    func configCell() {
        
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(15)
        }).config({ (titleLabel) in
            titleLabel.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
            titleLabel.sizeToFit()
        })
        
        self.contentTF = UITextView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(Margin)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
        }).config({ (contentTF) in
            contentTF.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            contentTF.font = UIFont.systemFont(ofSize: 13)
            contentTF.textAlignment = .justified
            contentTF.isUserInteractionEnabled = false
        })
    }
}
