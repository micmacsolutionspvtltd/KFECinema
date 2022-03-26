
import Foundation
import UIKit
import CoreLocation


class UITextFieldPadding : UITextField {

  let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
}

extension Encodable {
    var arrayDictionary: [[String: Any]]? {
       guard let data = try? JSONEncoder().encode(self) else { return nil }
       return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [[String: Any]] }
     }
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

//extension UIApplication {
//
//    
//    
//    var statusBarView: UIView? {
//       return value(forKey: "statusBar") as? UIView
//     }
////   var statusBarView: UIView? {
////      return value(forKey: "statusBarWindow.statusBar") as? UIView
////    }
//
//}

extension UIApplication {
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}

extension UIView {
    
    func shake(offset: CGFloat = 20) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-offset, offset, -offset, offset, -offset/2, offset/2, -offset/4, offset/4, offset/4 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIView {
  

  func applyShadowView(color:UIColor,radius:CGFloat,cornerRadius:CGFloat, alpha: Float = 1.0) {
      self.layer.masksToBounds = false;
      self.layer.shadowColor = color.cgColor
      self.layer.shadowOpacity = alpha;
      self.layer.shadowRadius = radius;
      self.layer.shadowOffset = CGSize(width: -1, height: 1)
      self.layer.cornerRadius = cornerRadius
  }
}
extension UIView {
  
  
  /* Usage Example
   * bgView.addBottomRoundedEdge(desiredCurve: 1.5)
   */
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
}

extension UIView{
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func pushTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
        
    }
    
    func pullTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    func pullDownTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}

extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: "\(title) \n")//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        let paragraphStyle = NSMutableParagraphStyle()
            // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 4.0 // Whatever line spacing you want in points
        
            // *** Apply attribute to string ***
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributeString.length))
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        let paragraphStyle = NSMutableParagraphStyle()
            // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 4.0 // Whatever line spacing you want in points
        
            // *** Apply attribute to string ***
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributeString.length))
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}

/*
 Add Comma seperation to numbers
 */
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        numberFormatter.secondaryGroupingSize = 2
        
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension Date {
    
    var currentTimeZoneDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "IST")
        //        formatter.amSymbol = "AM"
        //        formatter.pmSymbol = "PM"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
    
    var currentDateOnly: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "IST")
        //        formatter.amSymbol = "AM"
        //        formatter.pmSymbol = "PM"
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: self)
    }
    
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "IST")
        //        formatter.amSymbol = "AM"
        //        formatter.pmSymbol = "PM"
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: self)
    }
    
    var addOneHour: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "IST")
        //        formatter.amSymbol = "AM"
        //        formatter.pmSymbol = "PM"
        formatter.dateFormat = "HH:mm:ss"
        
        let modifiedDate2 = Calendar.current.date(byAdding: .hour, value: +1, to: self)!
      
        return formatter.string(from: modifiedDate2)
    }
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func years(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }
    
    func months(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
    
    // convert Interger value
    var integerValue: Int? {
        return Int(self)
    }
    
    // compare to strings
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    
}

extension UIImage {
    
    func scaleToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }

}


  extension UIViewController {
      func hideKeyBoard() {
          let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          tap.cancelsTouchesInView = false
          self.view.addGestureRecognizer(tap)
      }
      
      @objc func dismissKeyboard(){
          self.view.endEditing(true)
      }
  }

 extension UIViewController {
     
     func showLocationEnableService()
     {
         let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)

         let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
             //Redirect to Settings app
             UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
         })

         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
         alertController.addAction(cancelAction)

         alertController.addAction(okAction)

         self.present(alertController, animated: true, completion: nil)
     }
     
     
     class var identifier: String {
         return "\(self)"
     }

   
//     static func instantiateFrom(storyboard: Storyboard) -> Self {
//         return storyboard.viewController(self)
//     }

    
     func checkForTextClicked(text: String, containerLabel: UILabel!, tapGesture: UITapGestureRecognizer, onSuccessCallBack: () -> Void) {

         let layoutManager = NSLayoutManager()
         let textContainer = NSTextContainer(size: CGSize.zero)
         let textStorage = NSTextStorage(attributedString: containerLabel.attributedText!)

         // Configure layoutManager and textStorage
         layoutManager.addTextContainer(textContainer)
         textStorage.addLayoutManager(layoutManager)

         // Configure textContainer
         textContainer.lineFragmentPadding = 0.0
         textContainer.lineBreakMode = containerLabel.lineBreakMode
         textContainer.maximumNumberOfLines = containerLabel.numberOfLines
             let labelSize = containerLabel.bounds.size
         textContainer.size = labelSize
         // Find the tapped character location and compare it to the specified range
         let locationOfTouchInLabel = tapGesture.location(in: containerLabel)
         let textBoundingBox = layoutManager.usedRect(for: textContainer)
         let textContainerOffset = CGPoint(
             x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
             y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
         )
         let locationOfTouchInTextContainer = CGPoint(
             x: locationOfTouchInLabel.x - textContainerOffset.x,
             y: locationOfTouchInLabel.y - textContainerOffset.y
         )
         let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
         
         let targetRange = NSString(string: containerLabel.text!).range(of: text)
         
         if NSLocationInRange(indexOfCharacter, targetRange) {
             onSuccessCallBack()
         }
         
     }
 }

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func base64ImageDecoded() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)!
        }
        return UIImage()
    }
    
    func convertToDictionary() -> NSDictionary {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }
    
}

extension UIViewController {
    static var bluringView : UIView?

    func addBlurView(){
        UIViewController.bluringView?.isHidden = false
        UIViewController.bluringView?.frame = view.bounds
        UIViewController.bluringView?.backgroundColor = .black
        UIViewController.bluringView?.alpha = 0.5
        UIViewController.bluringView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(UIViewController.bluringView!)
    }
    
    func addAndDisplayChildViewController(controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        view.bringSubviewToFront(controller.view)
        controller.didMove(toParent: self)
    }
    
    func removeAsChildViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        dismiss(animated: false) {
        }
    }
    
    func slideInAnimation() {
        self.view.frame.origin.x = 2 * self.view.frame.size.width
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.view.frame.origin.x = 0
        }, completion: nil)
    }
    
    func slideOutAnimation(completed: @escaping () -> Void) {
        self.view.frame.origin.x = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.view.frame.origin.x = -self.view.frame.size.width
        }) { (finished) -> Void in
            completed()
        }
    }
    
    func slideInAnimationForMenu() {
        self.view.frame.origin.x = -self.view.frame.size.width
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.view.frame.origin.x = 0
        }, completion: nil)
    }
    
    func slideOutAnimationForMenu() {
        self.view.frame.origin.x = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.view.frame.origin.x = -self.view.frame.size.width
        }, completion: nil)
    }
    
}

extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

public extension UIDevice {
    
    var modelName: String {
        #if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #endif
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        default:                                        return identifier
        }
    }
    
}

extension UIView {
    
    func applyBackgroundBottomCircleForView() {
//        let bottomCircle = CAShapeLayer()
//
//        backgroundColor = Constants.Color.White
//
//        let gradientFrame = CGRect(x: -25, y: 25, width: frame.size.width / 1.85, height: frame.size.height * 1.6)
//        let bottomCircleFrame = CGRect(x: 0, y: 0, width: frame.size.width / 1.85, height: frame.size.height * 1.45)
//        bottomCircle.frame = bottomCircleFrame
//        bottomCircle.path = UIBezierPath(ovalIn: bottomCircleFrame).cgPath
//
//        let gradient = CAGradientLayer()
//        gradient.frame = gradientFrame
//        gradient.startPoint = CGPoint(x: 0.5, y: 1)
//        gradient.endPoint = CGPoint(x: 1, y: 0.5)
//        gradient.colors = [Constants.Color.AppBlueColor.cgColor,
//                           Constants.Color.AppRedColor.cgColor]
//        gradient.mask = bottomCircle
//        layer.addSublayer(gradient)
    }
    
    func applyBackgroundTopCircleForView() {
        let topCircle = CAShapeLayer()

        backgroundColor = Constants.Color.White

        let gradientFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let topCircleFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        topCircle.frame = topCircleFrame
//        topCircle.path = UIBezierPath(ovalIn: topCircleFrame).cgPath
        let center = CGPoint (x: frame.size.width / 2, y: -50)
        let circleRadius = frame.size.width / 1.5
        topCircle.path = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 2), clockwise: false).cgPath

        let gradient = CAGradientLayer()
        gradient.frame = gradientFrame
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.colors = [Constants.Color.AppPinkColor.cgColor, Constants.Color.AppOrangeColor.cgColor]
        gradient.mask = topCircle
        layer.addSublayer(gradient)
    }
    
}

extension UIView {
    func fit(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}



//public func showToast(inView view: UIView, withTitle title: String = "", withMessage message: String, dismissDelay: TimeInterval = 3.0, position: CGPoint? = nil) {
//        var style = ToastStyle()
//        style.messageColor =  UIColor.white
//        style.backgroundColor = UIColor.darkGray
//        if let pos = position {
//            view.makeToast(message, duration: dismissDelay, position: pos, style: style)
//        } else {
//            view.makeToast(message, duration: dismissDelay, position: .bottom, style: style)
//        }
//    }
//
//public func showToastTop(inView view: UIView,withMessage message: String) {
//    var style = ToastStyle()
//    style.messageColor =  UIColor.white
//    style.backgroundColor = UIColor.darkGray
//    view.makeToast(message, duration: 3.0, position: .top, style: style)
//}

//public func applyCocoaTextFieldValues(textfield:CocoaTextField,hint:String,borderColor:UIColor? = UIColor.gray.withAlphaComponent(0.5),borderWidth:CGFloat? = 1.0){
//    textfield.placeholder = hint
//    textfield.inactiveHintColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
//    textfield.activeHintColor = UIColor(red: 94/255, green: 186/255, blue: 187/255, alpha: 1)
//    textfield.focusedBackgroundColor = UIColor.white
//    textfield.defaultBackgroundColor = UIColor.white
//    textfield.borderColor = borderColor!
//    textfield.errorColor = UIColor.gray.withAlphaComponent(0.5)
////    textfield.borderWidth = borderWidth!
////    textfield.cornerRadius = 5
//}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension UIAlertAction {
    convenience init(title: String?, style: UIAlertAction.Style, image: UIImage, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, style: style, handler: handler)
        self.actionImage = image
    }
    
    convenience init?(title: String?, style: UIAlertAction.Style, imageNamed imageName: String, handler: ((UIAlertAction) -> Void)? = nil) {
        if let image = UIImage(named: imageName) {
            self.init(title: title, style: style, image: image, handler: handler)
        } else {
            return nil
        }
    }
    
    var actionImage: UIImage {
        get {
            return self.value(forKey: "image") as? UIImage ?? UIImage()
        }
        set(image) {
            self.setValue(image, forKey: "image")
        }
    }
}

//extension UIView {
//   func createDottedLine(width: CGFloat, color: CGColor) {
//      let caShapeLayer = CAShapeLayer()
//      caShapeLayer.strokeColor = color
//      caShapeLayer.lineWidth = width
//      caShapeLayer.lineDashPattern = [2,3]
//      let cgPath = CGMutablePath()
//      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
//      cgPath.addLines(between: cgPoint)
//      caShapeLayer.path = cgPath
//      layer.addSublayer(caShapeLayer)
//   }
//}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension UIColor {
    
    // You can directly make some static color using this way.
    static let kAppTheme = UIColor(red: 123, green: 56, blue: 243)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    class func colorWithHex(hex: String) -> UIColor {
        
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove prefix if contain # at 0th position.
        if colorString.hasPrefix("#") { colorString.remove(at: colorString.startIndex) }
        if colorString.count != 6 { return UIColor.gray }
        
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    private func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    struct AppColor {
        struct Green {
            static let Fern = UIColor(netHex: 0x6ABB72)
            static let MountainMeadow = UIColor(netHex: 0x3ABB9D)
            static let ChateauGreen = UIColor(netHex: 0x4DA664)
            static let PersianGreen = UIColor(netHex: 0x2CA786)
        }
    }
    
    static var random: UIColor {
        let max = CGFloat(UInt32.max)
        let red = CGFloat(arc4random()) / max
        let green = CGFloat(arc4random()) / max
        let blue = CGFloat(arc4random()) / max
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

extension UIScrollView {

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y - 70,width: 1,height: self.frame.height), animated: animated)
        }
    }

    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }

}

extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }

            if let country = country {
                result += ", \(country)"
            }

            return result
        }

        return nil
    }

}

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension UIView {
    private static let lineDashPattern: [NSNumber] = [4, 4]
    private static let lineDashWidth: CGFloat = 1.0

    func makeDashedBorderLine() {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = UIView.lineDashWidth
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = UIView.lineDashPattern
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height/2),
                                CGPoint(x: bounds.maxX, y: bounds.height/2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

@available(iOS 13.0, *)
extension UIResponder {
    @objc var scene: UIScene? {
        return nil
    }
}

@available(iOS 13.0, *)
extension UIScene {
    @objc override var scene: UIScene? {
        return self
    }
}

@available(iOS 13.0, *)
extension UIView {
    @objc override var scene: UIScene? {
        if let window = self.window {
            return window.windowScene
        } else {
            return self.next?.scene
        }
    }
}

@available(iOS 13.0, *)
extension UIViewController {
    @objc override var scene: UIScene? {
        // Try walking the responder chain
        var res = self.next?.scene
        if (res == nil) {
            // That didn't work. Try asking my parent view controller
            res = self.parent?.scene
        }
        if (res == nil) {
            // That didn't work. Try asking my presenting view controller
            res = self.presentingViewController?.scene
        }

        return res
    }
}

extension UIColor {
    public convenience init(RGB: Int) {
        var rgb = RGB
        rgb = rgb > 0xffffff ? 0xffffff : rgb
        let r = CGFloat(rgb >> 16) / 255.0
        let g = CGFloat(rgb >> 8 & 0x00ff) / 255.0
        let b = CGFloat(rgb & 0x0000ff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    public func getTransformedColor(saturation: CGFloat, brightness: CGFloat) -> UIColor {
        var hsb = getHSBColor()
        hsb.s *= saturation
        hsb.b *= brightness
        if hsb.s > 1 { hsb.s = 1 }
        if hsb.b > 1 { hsb.b = 1 }
        return hsb.uiColor
    }
    private func getHSBColor() -> HSBColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return HSBColor(h: h, s: s, b: b, alpha: a)
    }
}

private struct HSBColor {
    var h: CGFloat
    var s: CGFloat
    var b: CGFloat
    var alpha: CGFloat
    init(h: CGFloat, s: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.h = h
        self.s = s
        self.b = b
        self.alpha = alpha
    }
    var uiColor: UIColor {
        get {
            return UIColor(hue: h, saturation: s, brightness: b, alpha: alpha)
        }
    }
}
