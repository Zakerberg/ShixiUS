 //
 //  Common.swift
 //  SX_NetWork
 //
 //  Created by Micahel 柏 on 2018/1/15.
 //  Copyright © 2018年 Shixi (Beijing) Technology Limited (Company). All rights reserved.
 //  
 
 import UIKit
 import SnapKit
 // ===================================================================================================================
 // MARK: - UIColor
 // ===================================================================================================================
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
    
    class func SX_LineColor() -> UIColor {
        return colorWithHexString(hex: "e5e5e5", alpha: 1.0)
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
 
 // ===================================================================================================================
 // MARK: - UIImage Extension
 // ===================================================================================================================
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
 
 // ===================================================================================================================
 // MARK: - Chainable UI
 // ===================================================================================================================
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
 
 // ======================================================================================================================
 //MARK: - NSString Extension
 // ======================================================================================================================
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
 
 extension CGFloat {
    var IPAD_XValue:CGFloat{return CGFloat(self*SCREEN_WIDTH)/375}
 }
 
 //打印信息
 func SXLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\n>>> \(Date())  \(fileName) (line: \(lineNum)): \(message)\n")
    #endif
 }
 
 
 // ==================================================================================================================
 // MARK: - UILabel Extension
 // ==================================================================================================================
 extension UILabel {
    
    /**
     *  计算UILabel的高度(带有行间距的情况)
     *  @param text  内容
     *  @param font  字体
     *  @param width 宽度
     *  @return 高度
     *  @param zpace  字间距 --> @10 这样设置  默认的话设置 0 就ok
     */
    class func SX_getSpaceLabelHeight(_ text: NSString, font: UIFont, width: CGFloat, space: CGFloat, zpace: NSNumber) -> CGFloat {
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment              = .left
        paraStyle.headIndent             = 0
        paraStyle.tailIndent             = 0
        paraStyle.lineSpacing            = space
        paraStyle.lineBreakMode          = .byCharWrapping
        paraStyle.firstLineHeadIndent    = 0.0
        paraStyle.hyphenationFactor      = 1.0
        paraStyle.paragraphSpacingBefore = 0.0
        
        //设置字间距 NSKernAttributeName: 0.5.FloatValue
        var dic = NSDictionary()
        if zpace == 0 {
            dic = [kCTFontAttributeName: font, kCTParagraphStyleAttributeName: paraStyle, kCTKernAttributeName: 0.5]
        } else {
            dic = [kCTFontAttributeName: font, kCTParagraphStyleAttributeName: paraStyle, kCTKernAttributeName: zpace]
        }
        
        let size = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context: nil)
        
        return size.height
        
    }
 }
 
 // ======================================================================================================================
 // MARK: - setRightItem
 // =======================================================================================================================
 extension UIViewController {
    
    func setRightItem(_ imageName: String) {
        
        let imageItem = UIBarButtonItem(image: UIImage.init(named: imageName), style: .plain, target: self, action: #selector(rightAction))
        imageItem.setBackgroundImage(UIImage.init(named: "mask"), for: .normal, barMetrics: .default)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = 0
        self.navigationItem.rightBarButtonItems = [imageItem]
    }
    
    
    func setLeftItem(_ imageName: String) {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        btn.setBackgroundImage(UIImage.init(named: "mask"), for: .normal)
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.addTarget(self, action: #selector(leftBackAction), for: .touchUpInside)
        
        let leftItem = UIBarButtonItem(customView: btn)
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftItem]
    }
    
    @objc func rightAction() {
        SXLog("share.....还没写,慢慢填坑......") 
    }
    
    @objc func leftBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
 }
 
 // ===================================================================================================================
 // MARK: - UIButton Extension
 // ===================================================================================================================
 extension UIButton {
    
    func addTimer(_ timeOut: Int, btn: UIButton){
        //倒计时时间
        var timeout = timeOut
        let queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let _timer:DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        _timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        //每秒执行
        _timer.setEventHandler(handler: { () -> Void in
            if(timeout<=0){ //倒计时结束，关闭
                _timer.cancel();
                DispatchQueue.main.sync(execute: { () -> Void in
                    btn.setTitle("重新获取", for: UIControlState())
                    btn.isEnabled = true
                    btn.layer.backgroundColor = UIColor.SX_MainColor().cgColor
                })
            }else{//正在倒计时
                let seconds = timeout
                _ = NSString.localizedStringWithFormat("%.2d", seconds)
                DispatchQueue.main.sync(execute: { () -> Void in
                    btn.isEnabled = false
                    btn.layer.backgroundColor = UIColor.gray.cgColor
                })
                timeout -= 1;
            }
        })
        _timer.resume()
    }
 }
 
 
 // ===================================================================================================================
 // MARK: - UIView Extension
 // ===================================================================================================================
 extension UIView {
 
    var x: CGFloat {
        get{
            return frame.origin.x
        }
        set(newValue){
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get{
            return frame.origin.y
        }
        set(newValue){
            frame.origin.y = newValue
        }
    }
    
    var centerX: CGFloat {
        get{
            return center.x
        }
        set(newValue){
            center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get{
            return center.y
        }
        set(newValue){
            center.y = newValue
        }
    }
    
    var width: CGFloat {
        get{
            return frame.size.width
        }
        set(newValue){
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get{
            return frame.size.height
        }
        set(newValue){
            frame.size.height = newValue
        }
    }
    
    var size: CGSize {
        get{
            return bounds.size
        }
        set(newValue){
            frame.size = newValue
        }
    }
    
    var origin: CGPoint {
        get{
            return frame.origin
        }
        set(newValue){
            frame.origin = newValue
        }
    }
 }
 
 
