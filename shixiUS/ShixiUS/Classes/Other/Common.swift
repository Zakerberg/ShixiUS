 //
 //  Common.swift
 //  SX_NetWork
 //
 //  Created by Micahel 柏 on 2018/1/15.
 //  Copyright © 2018年 Shixi (Beijing) Technology Limited (Company). All rights reserved.
 //
 
 import UIKit
 import SnapKit
 
 // MARK: - UIColor
 extension UIColor {
    
    /// rgb颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 ,alpha:1.0)
    }
    
    /// 纯色（用于灰色）
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0 ,green: gray/255.0 ,blue: gray/255.0 ,alpha:1.0)
    }
    
    /// 随机色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    /// 主题颜色
    class func SX_MainColor() -> UIColor
    {
        return colorWithHexString(hex: "ff7900", alpha: 1.0)
    }
    
    class func SX_BackGroundColor() -> UIColor {
        return colorWithHexString(hex: "f3f4f8", alpha: 1.0)
    }
    
    static func colorWithHexString(hex: String, alpha: CGFloat) -> UIColor {
        
        var cString: NSString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1) as NSString
        }
        
        if (cString.hasPrefix("0X") || cString.hasPrefix("0x")) {
            cString = cString.substring(from: 2) as NSString
        }
        
        if (cString.length != 6) {
            return UIColor.clear
        }
        
        let rString = cString.substring(with: NSMakeRange(0, 2))
        let gString = cString.substring(with: NSMakeRange(2, 2))
        let bString = cString.substring(with: NSMakeRange(4, 2))
        
        var r : CUnsignedInt = 0x0,
        g : CUnsignedInt = 0x0,
        b : CUnsignedInt = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    class func hexInt(_ hexValue: Int) -> UIColor {
        
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hexValue & 0xFF)) / 255.0, alpha: 1.0)
    }
 }
 
 // MARK: - UIImage Extension
 extension UIImage {
    
    var height:CGFloat{return self.size.height}
    var width:CGFloat{return self.size.width}
    
    /// 根据颜色生成一张纯色图片
    class func imageWithColor(color : UIColor ,size : CGSize) -> UIImage{
        let rect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    /// 压缩图片,并返回压缩后的图片
    func iamgeCompress (targetWight:CGFloat) -> UIImage {
        let targetHeight = (targetWight/width)*height
        UIGraphicsBeginImageContext(CGSize(width: targetWight, height: targetHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: targetWight, height: targetHeight))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片模糊处理
    func blurImage(value:NSNumber) -> UIImage {
        let context = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        let ciImage = CIImage(image:self)
        //滤镜
        let blurFilter = CIFilter(name: "CIGuassianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(value, forKey: "inputRadius")
        let imageRef = context.createCGImage((blurFilter?.outputImage)!, from: (ciImage?.extent)!)
        let newImage = UIImage(cgImage: imageRef!)
        return newImage
    }
 }
 
 // UI
 protocol ViewChainable { }
 extension ViewChainable where Self: UIView {
    @discardableResult
    func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
 }
 
 extension UIView: ViewChainable {
    func addhere(toSuperView: UIView) -> Self {
        toSuperView.addSubview(self)
        return self
    }
    
    @discardableResult
    func  layout(snapKitMaker: (ConstraintMaker) -> Void) -> Self {
        self.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }
 }
 
 //宏定义
 // #define HexColor(HexValue,alphaValue) [UIColor colorWithRed:((float)((HexValue & 0xFF0000) >> 16))/255.0 green:((float)((HexValue & 0xFF00) >> 8))/255.0 blue:((float)(HexValue & 0xFF))/255.0 alpha:alphaValue]
 //使用,前面是十六进制值,后面是透明度(粉嫩色...)
 // self.view.backgroundColor = HexColor(0xFF335B,1.0f);
 
 
 //MARK: - NSString Extension
 extension NSString  {
    
    var md5: NSString! {
        let str = self.cString(using: String.Encoding.utf8.rawValue)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8.rawValue))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0...digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: digestLen)
        return String(format: hash as String) as NSString
    }
    
    class func jsonStringToDictionary (jsonstr: NSString) -> NSDictionary {
        do{
            let json = try JSONSerialization.jsonObject(with: jsonstr.data(using: String.Encoding.utf8.rawValue)!, options: .allowFragments)
            return json as! NSDictionary
        }catch{ }
        
        let str = NSDictionary()
        return str
    }
 }
 
 extension Int {
    var FloatValue:CGFloat{return CGFloat(self)}
    var DoubleValue:Double{return Double(self)}
 }
 
 
 //打印信息
 func SXLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\n>>> \(Date())  \(fileName) (line: \(lineNum)): \(message)\n")
    #endif
 }
