//
//  SX_HotJobsCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位Cell

import UIKit
import SDWebImage

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
            make.center.equalToSuperview()
            
        }).config({ (jobsLabel) in
            jobsLabel.text = "111111"
            jobsLabel.textColor = UIColor.black
        })
    }
    
    func reloadData(jobs: NSString, insduty: NSString,address: NSString,edu: NSString, logo: NSString)  {
        self.jobsLabel?.text = jobs as String
        self.addressLabel?.text = address as String
        self.eduLabel?.text = edu as String
        // self.logoImageView?.image = UIImage.sd_image(with: <#T##Data?#>)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
