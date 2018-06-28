//
//  SX_TrainingCollectionViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/26/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训CollectionViewCell

import UIKit

class SX_TrainingCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    var imageView: UIImageView?
    var descTitle: UILabel?
    var priceLabel: UILabel?
    var symbolLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "热门实训"
        self.titleLabel?.textColor = UIColor.gray
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    
    }
}

