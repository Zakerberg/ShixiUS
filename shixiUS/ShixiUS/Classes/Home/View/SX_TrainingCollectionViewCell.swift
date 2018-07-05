//
//  SX_TrainingCollectionViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/5/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_TrainingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var sourceTitle: UILabel!
    @IBOutlet weak var certificateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SXLog("走到这里了")
    }
}
