//
//  SX_NoDataView.swift
//  ShixiUS
//
//  Created by heather on 2018/10/11.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_NoDataView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = UIColor.SX_BackGroundColor()
        let imageV           = UIImageView(image: #imageLiteral(resourceName: "icon_nodata")).addhere(toSuperView: self).layout { (make) in
            make.center.equalToSuperview()
            }.config { (IMAGEV) in
        }
        
        let label = UILabel().addhere(toSuperView: self).layout { (make) in
            make.centerX.equalTo(imageV)
            make.top.equalTo(imageV.snp.bottom).offset(Margin)
            }.config { (LABEL) in
                LABEL.font      = UIFont.systemFont(ofSize: 16)
                LABEL.text      = "抱歉, 暂无数据"
                LABEL.textColor = UIColor.colorWithHexString(hex: "c2c9cf", alpha: 1)
        }
    }
}
