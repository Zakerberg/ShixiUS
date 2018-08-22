//
//  SX_HeadPortraitCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  头像Cell

import UIKit

class SX_HeadPortraitCell: UITableViewCell {
    
    var nameTitle             : UILabel?
    var logInButton           : UIButton?
    var headPortraitImageView : UIImageView?
    
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

// ==================================================================================================================
// MARK: - configCell()
// =================================================================================================================
extension SX_HeadPortraitCell {
    
    func configCell() {
        self.headPortraitImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.height.width.equalTo(60.FloatValue.IPAD_XValue)
        }).config({ (headPortrait) in
            headPortrait.layer.masksToBounds = true
            headPortrait.layer.cornerRadius  = 30
            headPortrait.image = #imageLiteral(resourceName: "icon")
            headPortrait.isUserInteractionEnabled = true
        })

        self.logInButton = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.headPortraitImageView!.snp.right).offset(10.FloatValue.IPAD_XValue)
            make.centerY.equalTo(self.headPortraitImageView!)
            make.height.equalTo(Margin)
        }).config({ (logIn) in
            logIn.setTitle("登录/注册  ", for: .normal)
            logIn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            logIn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            logIn.setTitleColor(UIColor.colorWithHexString(hex: "2d2d2d", alpha: 1), for: .normal)
            logIn.titleEdgeInsets = UIEdgeInsetsMake(0, -logIn.imageView!.bounds.size.width, 0, logIn.imageView!.bounds.size.width)
            logIn.imageEdgeInsets = UIEdgeInsetsMake(0, logIn.titleLabel!.bounds.size.width, 0, -logIn.titleLabel!.bounds.size.width)
        })
        
        self.nameTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.headPortraitImageView!.snp.right).offset(10.FloatValue.IPAD_XValue)
            make.centerY.equalTo(self.headPortraitImageView!)
            make.height.equalTo(Margin)
        }).config({ (Name) in
            Name.sizeToFit()
            Name.font = UIFont.systemFont(ofSize: 15)
            Name.textColor = UIColor.colorWithHexString(hex: "2d2d2d", alpha: 1)
            Name.text = "LLY19920924"
        })
    }
}
