//
//  SX_OverseaCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/16/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业Cell

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

// ==================================================================================================================================
// MARK: - Other Method
// ==================================================================================================================================
extension SX_OverseaCell {
    
    func configCell() {
        
        self.jobName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(Margin)
            make.height.equalTo(Margin)
            make.left.lessThanOrEqualTo(Margin)
            make.width.lessThanOrEqualTo(270)
        }).config({ (jobName) in
            jobName.text = "美国金融实习岗位-信托和过桥基金业务"
            jobName.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            jobName.font = UIFont.boldSystemFont(ofSize: 15)
            jobName.sizeToFit()
        })
        
        let addressImg = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            make.left.equalTo(self.jobName!.snp.left)
            make.top.equalTo(self.jobName!.snp.bottom).offset(10)
            make.width.height.equalTo(14)
            }.config { (addressImg) in
                addressImg.image = UIImage.init(named: "address")
        }
        
        self.address = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.address!.snp.right).offset(5)
            make.top.height.equalTo(self.address!)
        }).config({ (address) in
            address.sizeToFit()
            address.font = UIFont.systemFont(ofSize: 10)
            address.text = "美国/纽约-测试"
            address.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        let durationImg = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            make.left.equalTo(self.address!.snp.right).offset(10)
            make.height.top.equalTo(addressImg)
            }.config { (durationImg) in
                durationImg.image = UIImage.init(named: "Fulltime")
        }
        
        self.duration = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(durationImg.snp.right).offset(10)
            make.height.top.equalTo(addressImg)
        }).config({ (duration) in
            duration.sizeToFit()
            duration.font = UIFont.systemFont(ofSize: 10)
            duration.text = "全职-测试"
            duration.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        let natureImg = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            make.left.equalTo(self.duration!.snp.right).offset(10)
            make.height.top.equalTo(addressImg)
            }.config { (natureImg) in
                natureImg.image = UIImage.init(named: "intership")
        }
        
        self.nature = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(natureImg.snp.right).offset(10)
            make.height.top.equalTo(addressImg)
        }).config({ (nature) in
            nature.sizeToFit()
            nature.font = UIFont.systemFont(ofSize: 10)
            nature.text = "实习-测试"
            nature.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        self.date = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerX.height.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }).config({ (date) in
            date.sizeToFit()
            date.font = UIFont.systemFont(ofSize: 10)
            date.text = "2018.03.03"
            date.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
    }
}

