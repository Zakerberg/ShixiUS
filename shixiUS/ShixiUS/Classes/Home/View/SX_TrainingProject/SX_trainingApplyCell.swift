//
//  SX_trainingApplyCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/25/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_trainingApplyCell: UITableViewCell {

    var titleLabel : UILabel?
    var contentTF  : UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
// MARK: - ConfigCell
// ==================================================================================================================================
extension SX_trainingApplyCell {
    
    func ConfigCell() {
    
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (titleLabel) in
            
        })
    
        self.contentTF = UITextField().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (contentTF) in
            
        })
    }
}






