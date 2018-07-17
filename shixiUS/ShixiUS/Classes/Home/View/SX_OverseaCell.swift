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


// ========================================================================================================================================
// MARK: - Other Method
// ========================================================================================================================================
extension SX_OverseaCell {
    
    func configCell() {
        
        self.jobName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (jobName) in
            
        })
        
        let _ = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            
            }.config { (addressImg) in
                
        }
        
        self.address = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (address) in
            
        })
        
        let _ = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            
            }.config { (durationImg) in
                
        }
        
        self.duration = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (duration) in
            
        })
        
        let _ = UIImageView().addhere(toSuperView: self.contentView).layout { (make) in
            
            }.config { (natureImg) in
                
        }
        
        self.nature = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (nature) in
            
        })
        
        self.date = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (date) in
            
        })
    }
}

