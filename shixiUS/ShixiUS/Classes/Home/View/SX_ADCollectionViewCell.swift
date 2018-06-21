//
//  SX_ADCollectionViewCell.swift
//  SX_NetWork
//
//  Created by heather on 2018/3/21.
//  Copyright © 2018年 Shixi (Beijing) Technology Limited (Company). All rights reserved.
//

import UIKit
import SDWebImage

class SX_ADCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    var adScrollModel : SX_ADScrollModel? {
        didSet{
            imageView.sd_setImage(with: URL(string: (adScrollModel?.img_url ?? "")!), placeholderImage: UIImage(named: "placehold"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetUI
extension SX_ADCollectionViewCell {
    func setUI() {
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
}
