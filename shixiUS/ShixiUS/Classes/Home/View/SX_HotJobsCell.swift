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
    
    var stackView:UIStackView?
    
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
            make.left.equalTo(self.insduryLabel!.snp.left)
            make.top.equalTo(self.insduryLabel!.snp.bottom).offset(Margin)
            make.width.height.equalToSuperview().offset(15)
            
        }).config({ (addImageView) in
            addImageView.image = UIImage(named: "address")
        })
        
        self.addressLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.addImageView!.snp.right).offset(Margin)
            make.top.height.width.equalTo(self.addImageView!)
        }).config({ (addressLabel) in
            addressLabel.sizeToFit()
            addressLabel.font = UIFont.systemFont(ofSize: 10)
            addressLabel.text = "美国/纽约 测试"
        })
        
        self.eduImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.addressLabel!.snp.right).offset(Margin)
            make.top.width.height.equalTo(self.addImageView!)
        }).config({ (eduImageView) in
            eduImageView.image = UIImage(named: "education")
        })
        
        self.eduLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.addressLabel!.snp.right).offset(Margin)
            make.top.height.width.equalTo(self.addImageView!)
        }).config({ (eduLabel) in
            eduLabel.text = "本科-测试"
            eduLabel.font = UIFont.systemFont(ofSize: 10)
            eduLabel.sizeToFit()
        })
        
        
        //        self.stackView = UIStackView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        //            make.top.equalTo(self.insduryLabel!.snp.bottom).offset(Margin)
        //            make.height.equalToSuperview().offset(14)
        //
        //        }).config({ (stackView) in
        //            stackView.sizeToFit()
        //            stackView.spacing = 5
        //            stackView.insertArrangedSubview(self.addImageView!, at: 0)
        //            stackView.insertArrangedSubview(self.addressLabel!, at: 1)
        //            stackView.insertArrangedSubview(self.eduImageView!, at: 2)
        //            stackView.insertArrangedSubview(self.eduLabel!, at: 3)
        //        })
        
        self.logoImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.jobsLabel!)
            make.left.equalToSuperview().offset(Margin)
            make.width.width.equalToSuperview().offset(60)
        }).config({ (logoImageView) in
            logoImageView.image = UIImage.init(named: "test000")
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
