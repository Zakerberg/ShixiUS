//
//  SX_OverseaCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/16/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业Cell

/*
岁月荏苒
青灯孤影月为伴
弱水三千不敌昔日你巧笑嫣然
 */

import UIKit

class SX_OverseaCell: UITableViewCell {
    
    var jobName:UILabel?
    var address:UILabel?
    var duration:UILabel?
    var nature:UILabel?
    var date:UILabel?
    
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

// ======================================================
// MARK: - Other Method
// ======================================================
extension SX_OverseaCell {
    
    func configCell() {
        
        self.jobName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(Margin)
            make.height.equalTo(Margin)
            make.left.lessThanOrEqualTo(Margin)
            make.width.equalToSuperview()
        }).config({ (jobName) in
            jobName.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            jobName.font = UIFont.boldSystemFont(ofSize: 15)
            jobName.sizeToFit()
        })
        
        let addressImg = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            make.left.equalTo(self.jobName!.snp.left)
            make.top.equalTo(self.jobName!.snp.bottom).offset(Margin)
            make.width.height.equalTo(14)
            }.config { (addressImg) in
                addressImg.image = #imageLiteral(resourceName: "address")
        }
        
        self.address = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(addressImg.snp.right).offset(5)
            make.top.height.equalTo(addressImg)
        }).config({ (address) in
            address.sizeToFit()
            address.font = UIFont.systemFont(ofSize: 10)
            address.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        let durationImg = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            make.left.equalTo(self.address!.snp.right).offset(10)
            make.height.top.equalTo(addressImg)
            }.config { (durationImg) in
                durationImg.image = #imageLiteral(resourceName: "Fulltime")
        }
        
        self.duration = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(durationImg.snp.right).offset(5)
            make.height.top.equalTo(addressImg)
        }).config({ (duration) in
            duration.sizeToFit()
            duration.font = UIFont.systemFont(ofSize: 10)
            duration.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        let natureImg = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            make.left.equalTo(self.duration!.snp.right).offset(10)
            make.height.top.equalTo(addressImg)
            }.config { (natureImg) in
                natureImg.image = #imageLiteral(resourceName: "intership")
        }
        
        self.nature = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(natureImg.snp.right).offset(5)
            make.height.top.equalTo(addressImg)
        }).config({ (nature) in
            nature.sizeToFit()
            nature.font = UIFont.systemFont(ofSize: 10)
            nature.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        self.date = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.height.equalTo(addressImg)
            make.right.equalToSuperview().offset(-12)
        }).config({ (date) in
            date.sizeToFit()
            date.font = UIFont.systemFont(ofSize: 10)
            date.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
    }
}

