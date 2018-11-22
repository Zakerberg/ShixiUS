 //
 //  Common.swift
 //  SX_NetWork
 //
 //  Created by Micahel 柏 on 2018/1/15.
 //  Copyright © 2018年 Shixi (Beijing) Technology Limited (Company). All rights reserved.
 //  
 
 /*
  我爱你
  遇见你之前
  我从不愿把日子过得平淡
  只为遇见你后
  每个和你相拥而眠的夜晚
  你躺在我的怀里
  我都有故事哄你
  用我最温柔的声音
  */
 
 import UIKit
 import SnapKit
 
 var maxTextNumberDegault = 30
 
 // ==============================================================================
 // MARK: - UIColor
 // ==============================================================================
 extension UIColor {
    
    /// rgb颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 ,alpha:1.0)
    }
    
    /// 纯色（用于灰色）
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0 ,green: gray/255.0 ,blue: gray/255.0 ,alpha:1.0)
    }
    
    class func colorWithRGBA(R:CGFloat, G:CGFloat, B:CGFloat, A:CGFloat) -> UIColor {
        return UIColor(red: R/255, green: G/255, blue: B/255, alpha: A)
    }
    
    /// 随机色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    /// 主题颜色
    class func SX_MainColor() -> UIColor {
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
    
    /// RGB Color
    class func colorWithRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
 }
 
 // ==============================================================================
 // MARK: - UIImage Extension
 // ==============================================================================
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
 
 // ==============================================================================
 // MARK: - UIView Extension Chainable UI
 // ==============================================================================
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
 
 // ==============================================================================
 //MARK: - NSString Extension MD5
 // ==============================================================================
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
 
 
 // ==============================================================================
 // MARK: - UILabel Extension
 // ==============================================================================
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
 
 // ==============================================================================
 // MARK: - setRightItem
 // ==============================================================================
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
        btn.frame = CGRect(x: 0, y: 0, width: 30.FloatValue.IPAD_XValue, height: 30.FloatValue.IPAD_XValue)
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
 
 // ==============================================================================
 // MARK: - UIButton Extension
 // ==============================================================================
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
 
 // ==============================================================================
 // MARK: - UIView Extension CustomFrame
 // ==============================================================================
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
 
 // ==============================================================================
 // MARK: - String Extension
 // ==============================================================================
 extension String {
    
    /// 计算文字宽度
    func SX_widthWithString(font: UIFont, size: CGSize) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// base 64
    var base64 :String{
        get{
            let strData = self.data(using: .utf8)
            let data64 = strData?.base64EncodedData()
            let str64 = String(data: data64!, encoding: .utf8)
            return str64 ?? ""
        }
    }
    
    func isValiteEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
 }
 
 // ==============================================================================
 // MARK: - CGRect
 // ==============================================================================
 extension CGRect {
    
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.minY, width: self.width, height: self.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRect(x: self.x, y: self.width, width: newValue, height: self.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRect(x: self.x, y: self.minY, width: self.width, height: newValue)
        }
    }
    
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
 }
 
 // ==============================================================================
 // MARK: - Timer
 // ==============================================================================
 extension Timer {
    class func schedule(delay: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    class func schedule(repeatInterval interval: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
 }
 
 // ==============================================================================
 // MARK: - UITextField
 // ==============================================================================
 extension UITextField {
    // 使用runtime给textField添加最大的输入属性, 默任15
    var maxTextNumber: Int {
        set {
            objc_setAssociatedObject(self, &maxTextNumberDegault, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &maxTextNumberDegault) as? Int {
                return rs
            }
            return 30
        }
    }
    
    // 添加判断数量的方法
    func addChangeTextTarget() {
        self.addTarget(self, action:#selector(changeText), for:.editingChanged)
    }
    @objc func changeText() {
        // 判断是不是拼音状态,拼音不截取文本
        if let positionRange = self.markedTextRange {
            guard self.position(from: positionRange.start, offset: 0) != nil else {
                checkTextFieldText()
                return
            }
        }else{
            checkTextFieldText()
        }
    }
    
    func checkTextFieldText() {
        guard (self.text?.length)! <= maxTextNumber else {
            self.text = (self.text?.stringCut(end: maxTextNumber))!
            return
        }
    }
 }
 
 extension String {
    
    var length: Int {
        /// 更改成其他的影响还有emoji协议的签名
        return self.utf16.count
    }
    
    /// 截取第一个到任意位置
    /// end: 结束的位置
    /// Returns: 截取后的字符串
    func stringCut(end: Int) -> String {
        if !(end <= count) { return self }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[..<sInde])
    }
 }
 
 // ==============================================================================
 // MARK: - Optional Extension - Emptiness(判空)
 // ==============================================================================
 extension Optional {
    /// 可选值为空的时候返回 true
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    /// 可选值非空返回 true
    var isSome: Bool {
        return !isNone
    }
    
    /****
     before:
     guard leftBtn != nil else { fatalError("Missing Interface Builder Connections") }
     
     now:
     guard leftBtn.isSome else { fatalError("Missing Interface Builder Connections") }
     */
 }
 
 // ==============================================================================
 // MARK: - Optional Extension - Or (或)
 // ==============================================================================
 extension Optional {
    /// 返回可选值或者默认值
    ///  - 参数: 如果可选值为空, 将会默认值
    func or(_ default: Wrapped) ->Wrapped {
        return self ?? `default`
    }
    
    /// 返回可选值 或 `else` 表达式返回的值
    /// eg: optional.or(else: print("Arr"))
    func or(else: @autoclosure() -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 返回可选值 或 `else` 闭包返回的值
    /// eg: optional.or(else: {
    ///  ... do a lot of stuff
    ///   })
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 当可选值不为空时候. 返回可选值
    /// 为空, 抛出异常
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { return exception as! Wrapped }
        return unwrapped
    }
    
    
    /*************** before
     func buildCar() throws -> Car {
     let tires = try machine1.createTires()
     let windows = try machine2.createWindows()
     guard let motor = externalMachine.deliverMotor() else {
     throw MachineError.motor
     }
     let trunk = try machine3.createTrunk()
     if let car = manufacturer.buildCar(tires, windows,  motor, trunk) {
     return car
     } else {
     throw MachineError.manufacturer
     }
     }
     ****************/
    
    /*************** now
     func build_car() throws -> Car {
     let tires = try machine1.createTires()
     let windows = try machine2.createWindows()
     let motor = try externalMachine.deliverMotor().or(throw: MachineError.motor)
     let trunk = try machine3.createTrunk()
     return try manufacturer.buildCar(tires, windows,  motor, trunk).or(throw: MachineError.manufacturer)
     }
     ****************/
    
 }
 
 extension Optional where Wrapped == Error {
    /// 当可选值不为空时, 执行`else`
    func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
 }
 
 // ==============================================================================
 // MARK: - Optional Extension Handling Errors(错误处理)
 // ==============================================================================
 extension Optional {
    func should(_ do: () throws -> Void) -> Error? {
        do {
            try `do`()
            return nil
        } catch let error {
            return error
        }
    }
    
    /****************** before
     do {
     try throwingFunction()
     } catch let error {
     print(error)
     }
     ********************/
    
    /************ now
     should { try throwingFunction() }.or(print($0))
     ************/
 }
 
 // ==============================================================================
 // MARK: - Optional Extension - Map (变换)
 // ==============================================================================
 extension Optional {
    
    
 }
 
 // ==============================================================================
 // MARK: - Optional Extension - Combining Optionals (组合可选值)
 // ==============================================================================
 extension Optional {
    
    
 }
 
 // ==============================================================================
 // MARK: - Optional Extension - On
 // ==============================================================================
 extension Optional {
    
    
 }
 
 // ==============================================================================
 // MARK: - Optional Extension - Various
 // ==============================================================================
 extension Optional {
    
    
 }
 
 
 // ================================================  |  ===============================================
 // ================================================  |  ===============================================
 // ================================================  | ================================================
 // ================================================  以  ==============================================
 // ================================================  下  ==============================================
 // ================================================  是 ===============================================
 // ================================================  日  ==============================================
 // ================================================  历  ==============================================
 // ================================================  部  ==============================================
 // ================================================  分  ==============================================
 // ================================================  |  ===============================================
 // ================================================  |  ===============================================
 // ================================================  |  ===============================================
 
 // ==============================================================================
 // MARK: - NSDate Extension
 // ==============================================================================
 extension NSDate {
    
    /// 计算这个月有多少天
    func numberOfDaysInCurrentMonth() -> Int {
        // 频繁调用 NSCalendar.current 可能有性能问题
        return ((NSCalendar.current.range(of: .day, in: .month, for: self as Date))?.count)!
    }
    
    /// 获取这个月有多少周
    func numberOfWeeksInCurrentMonth() -> NSInteger {
        let weekDay:NSInteger = self.firstDayOfCurrentMonth().weeklyOrdinality()
        var days:NSInteger    = self.numberOfDaysInCurrentMonth()
        
        var weeks = 0
        if weekDay > 1 {
            weeks += 1
            days -= (7 - weekDay + 1)
        }
        weeks += days/7
        weeks += (days%7 > 0) ? 1 : 0
        
        return weeks
    }
    
    /*计算这个月最开始的一天*/
    func firstDayOfCurrentMonth() -> NSDate {
        let startDate = NSDate()
        // let Ok: Bool  = NSCalendar.current.startOfDay(for: startDate)
        
        return startDate
    }
    
    /*计算这个月的第一天是礼拜几*/
    func weeklyOrdinality() -> NSInteger {
        return NSCalendar.current.ordinality(of: .day, in: .weekday, for: self as Date)!
    }
    
    //
    //    func lastDayOfCurrentMonth() -> NSDate {
    //
    //    }
    //
    //    func dayInThePreviousMonth() -> NSDate {
    //
    //    }
    //
    //    func dayInFollowingMonth() -> NSDate {
    //
    //    }
    //
    //    /// 获取当前日期之前后的几个月
    //    func dayInTheFollowingMonth(month: Int) -> NSDate {
    //
    //    }
    //
    //    /// 获取当前日期之前后的几天
    //    func dayInTheFollowingDay(day: Int) -> NSDate {
    //
    //
    //    }
    //
    //    func YMDComponents() {
    //
    //    }
    //
    //    /// NSString 转 NSDate
    //    func dateFormString(dateString: NSString) -> NSDate {
    //
    //    }
    //
    //    /// NSDate 转 NSString
    //    func stringFormDate(date: NSDate) -> NSString {
    //
    //    }
    //
    //    class func getDayNumbertoDay(_ today: NSDate, beforeDay: NSDate) -> Int {
    //
    //    }
    //
    //    func getweekInValueWithDate() -> Int {
    //
    //    }
    //
    //    /// 判断日期是今天,明天,后天,周几
    //    func compareIfTodayWithDate() -> NSString {
    //
    //    }
    //
    //    /// 通过数字返回星期几
    //    class func getWeekStringFormInteger(week:Int) -> NSString {
    //
    //    }
 }
 
 
 
 
