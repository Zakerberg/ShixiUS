//
//  SX_CustomNavigationBar.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

fileprivate let SXDefaultTitleSize:CGFloat = 18
fileprivate let SXDefaultTitleColor = UIColor.black
fileprivate let SXDefaultBackgroundColor = UIColor.white

// MARK: - Router
extension UIViewController {

    func sx_toLastViewController(animated: Bool) {
    
        if self.navigationController != nil {
         
            if self.navigationController?.viewControllers.count == 1 {
                
                self.dismiss(animated: animated, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: animated)
            }
        } else if self.presentationController != nil {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
    class func sx_currentViewController() -> UIViewController {
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            return self.sx_currentViewController(from: rootVC)
        }else {
            return UIViewController()
        }
    }
    
//    class func sx_currentViewController(from fromVC:UIViewController) -> UIViewController {
//        
//
//        
//    }
}

class SX_CustomNavigationBar: UIView {

    var onClickLeftBtn:(()->())?
    var onClickRightBtn:(()->())?
    
    var title: String? {
        willSet{
            
        }
    }
    
//    var titleColor: UIColor? {
//        willSet {
//             
//        }
//    }
}
