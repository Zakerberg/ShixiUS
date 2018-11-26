//
//  SX_HeadPortraitCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  头像Cell

/*
 我爱你
 不想做你的观众，也不想打探你的人生
 只是偶尔会期望我们的相逢会在一个午后
 蔷薇热烈，你对着我的狗点了点头
 */

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

// ============================================================================
// MARK: - configCell()
// ============================================================================
extension SX_HeadPortraitCell {
    
    func configCell() {
        self.headPortraitImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.height.width.equalTo(60.FloatValue.IPAD_XValue)
        }).config({ (HEAD) in
            HEAD.layer.masksToBounds      = true
            HEAD.layer.cornerRadius       = 30.FloatValue.IPAD_XValue
            HEAD.isUserInteractionEnabled = true
            HEAD.image                    = UIImage(named: "icon_head")
        })
        
        self.logInButton = UIButton().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.headPortraitImageView!.snp.right).offset(10.FloatValue.IPAD_XValue)
            make.centerY.equalTo(self.headPortraitImageView!)
            make.height.equalTo(Margin)
        }).config({ (LOGIN) in
            LOGIN.setTitle("登录/注册  ", for: .normal)
//            logIn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            LOGIN.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            LOGIN.setTitleColor(UIColor.colorWithHexString(hex: "2d2d2d", alpha: 1), for: .normal)
            LOGIN.titleEdgeInsets  = UIEdgeInsetsMake(0, -LOGIN.imageView!.bounds.size.width, 0, LOGIN.imageView!.bounds.size.width)
            LOGIN.imageEdgeInsets  = UIEdgeInsetsMake(0, LOGIN.titleLabel!.bounds.size.width, 0, -LOGIN.titleLabel!.bounds.size.width)
        })
        
        self.nameTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.headPortraitImageView!.snp.right).offset(10.FloatValue.IPAD_XValue)
            make.centerY.equalTo(self.headPortraitImageView!)
            make.height.equalTo(Margin)
        }).config({ (NAME) in
            NAME.sizeToFit()
            NAME.font = UIFont.systemFont(ofSize: 15)
            NAME.textColor = UIColor.colorWithHexString(hex: "2d2d2d", alpha: 1)
//            Name.text = "LLY19920924"
        })
    }
}
