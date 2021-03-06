//
//  SX_HotJobsCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位Cell

/*
 现在，你相伴身旁
 我写情诗
 描绘世间的美好
 */

import UIKit
import Kingfisher

class SX_HotJobsCell: UITableViewCell {
    
    var jobsLabel: UILabel?
    var insduryLabel: UILabel?
    var addressLabel:UILabel?
    var eduLabel:UILabel?
    var addImageView:UIImageView?
    var eduImageView:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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

// =============================================================================
// MARK: - configCell()
// ==============================================================================
extension SX_HotJobsCell {
    
    func configCell() {
        
        self.jobsLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(Margin)
            make.height.equalTo(Margin)
            make.left.lessThanOrEqualTo(Margin)
            make.width.lessThanOrEqualTo(270)
        }).config({ (jobsLabel) in
            jobsLabel.text = "美国金融实习岗位-信托和过桥基金业务"
            jobsLabel.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            jobsLabel.font = UIFont.boldSystemFont(ofSize: 15)
            jobsLabel.sizeToFit()
        })
        
        self.insduryLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.jobsLabel!.snp.bottom).offset(10)
            make.left.equalTo(self.jobsLabel!.snp.left)
        }).config({ (insduryLabel) in
            insduryLabel.text = "金融/国际贸易"
            insduryLabel.font = UIFont.systemFont(ofSize: 12)
            insduryLabel.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            insduryLabel.sizeToFit()
        })
        
        self.addImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.insduryLabel!.snp.left)
            make.top.equalTo(self.insduryLabel!.snp.bottom).offset(10)
            make.width.height.equalTo(14)
        }).config({ (addImageView) in
            addImageView.image = UIImage(named: "address")
        })
        
        self.addressLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.addImageView!.snp.right).offset(5)
            make.top.height.equalTo(self.addImageView!)
        }).config({ (addressLabel) in
            addressLabel.sizeToFit()
            addressLabel.font = UIFont.systemFont(ofSize: 10)
            addressLabel.text = "美国/纽约-测试"
            addressLabel.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        self.eduImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.addressLabel!.snp.right).offset(10)
            make.width.top.equalTo(self.addImageView!)
        }).config({ (eduImageView) in
            eduImageView.image = UIImage(named: "education")
        })
        
        self.eduLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.eduImageView!.snp.right).offset(5)
            make.top.height.equalTo(self.addImageView!)
        }).config({ (eduLabel) in
            eduLabel.font = UIFont.systemFont(ofSize: 10)
            eduLabel.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            eduLabel.sizeToFit()
        })
    }
    
    func reloadData(jobs: NSString, insduty: NSString,address: NSString,edu: NSString, logo: NSString)  {
        self.jobsLabel?.text = jobs as String
        self.addressLabel?.text = address as String
        self.eduLabel?.text = edu as String
    }
    
    func configCell(jobsModel: SX_HomeJobsModel) {
        self.jobsLabel?.text = jobsModel.name
        self.insduryLabel?.text = jobsModel.nature
        self.addressLabel?.text = jobsModel.address
        self.eduLabel?.text = jobsModel.trade
    }
}

