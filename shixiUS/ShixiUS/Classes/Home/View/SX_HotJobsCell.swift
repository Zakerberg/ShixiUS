//
//  SX_HotJobsCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位Cell

import UIKit
import Kingfisher

class SX_HotJobsCell: UITableViewCell {
    
    var jobsLabel: UILabel?
    var insduryLabel: UILabel?
    var addressLabel:UILabel?
    var eduLabel:UILabel?
    var addImageView:UIImageView?
    var eduImageView:UIImageView?
    var logoImageView:UIImageView?
    
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
    
    func configCell() {
        
        self.jobsLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.width.equalToSuperview().offset(140)
            
        }).config({ (jobsLabel) in
            jobsLabel.text = "美国金融实习岗位-信托和过桥基金业务---测试"
            jobsLabel.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            jobsLabel.font = UIFont.boldSystemFont(ofSize: 18)
            jobsLabel.numberOfLines = 0
            jobsLabel.sizeToFit()
        })
        
        self.insduryLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.jobsLabel!.snp.bottom).offset(Margin)
            make.left.equalTo(self.jobsLabel!.snp.left)
            
        }).config({ (insduryLabel) in
            insduryLabel.text = "金融/国际贸易---测试"
            insduryLabel.font = UIFont.systemFont(ofSize: 12)
            insduryLabel.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            insduryLabel.sizeToFit()
        })
        
        self.addImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
            
        }).config({ (addImageView) in
            addImageView.image = UIImage(named: "address")
        })
        
        self.addressLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
            
        }).config({ (addressLabel) in
            
            
        })
        
        self.eduImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
            
        }).config({ (eduImageView) in
            eduImageView.image = UIImage(named: "education")
        })
        
        self.eduLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (eduLabel) in
            
            
        })
    }
    
    func reloadData(jobs: NSString, insduty: NSString,address: NSString,edu: NSString, logo: NSString)  {
        self.jobsLabel?.text = jobs as String
        self.addressLabel?.text = address as String
        self.eduLabel?.text = edu as String
        self.logoImageView?.kf.setImage(with: URL(string: logo as String))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
