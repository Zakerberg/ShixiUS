//
//  SX_HotJobsCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位Cell

import UIKit

class SX_HotJobsCell: UITableViewCell {

    var jobsLabel: UILabel?
    var insduryLabel: UILabel?
    var addressLabel:UILabel?
    var eduLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
    
        self.jobsLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.center.equalToSuperview()
        }).config({ (jobsLabel) in
            
            jobsLabel.text = "111111"
            jobsLabel.textColor = UIColor.black
            
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
