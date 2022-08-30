//
//  ViewExtensions.swift
//
//  Created by Sahil Garg on 15/12/21.
//

import Foundation
import UIKit
import SDWebImage
import AVFoundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}

extension String {
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    func getDate() -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatterGet.date(from: self) ?? Date()
    }
    
    func getChatDateString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatterGet.date(from: self) ?? Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MMM-yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    func getChatTimeString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatterGet.date(from: self) ?? Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        return dateFormatterPrint.string(from: date)
    }
    
    func getChatHeaderDate() -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MMM-yyyy"
        let getDate = dateFormatterGet.date(from: self) ?? Date()
        
        if Calendar.current.compare(getDate, to: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, toGranularity: .day) == .orderedSame {
            return "Yesterday"
        }
        
        if Calendar.current.compare(getDate, to: Date(), toGranularity: .day) == .orderedSame {
            return "Today"
        }
        
        return self
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    func addAttributesToRangeString(rangeString:String, fontAttribute:UIFont = THFonts.appSemiBoldFont.withSize(14.0), colorAttribute:UIColor = THColors.themeColor) -> NSAttributedString? {
        let range = (self as NSString).range(of: rangeString)
        let mutableAttributedString = NSMutableAttributedString.init(string: self)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: fontAttribute,
            .foregroundColor: colorAttribute,
        ]
        mutableAttributedString.addAttributes(attributes, range: range)
        return mutableAttributedString
    }
    
    func addUnderLine(fontAttribute:UIFont = THFonts.appRegularFont.withSize(15.0)) -> NSAttributedString {
        let textRange = NSRange(location: 0, length: self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        return attributedText
    }
    
    func verifyUrl() -> Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
    
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)

        selectedTextRange = selection
    }
    
    func setPlaceholder(_ placeHolder:String,withColor color:UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func setRightIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = .lightGray
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 40))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
    
}

extension Int {
    
    var boolValue: Bool { return self != 0 }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func convertTimeStampToDateString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func convertTimeStampToCommentDateString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

extension Date {
    
    func getDateMMMMDDString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMMM, dd"
        return dateFormatterGet.string(from: self)
    }
    
    func getDateYYYYMMDDString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        return dateFormatterGet.string(from: self)
    }
    
    func convertDateToTimeString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        return dateFormatterGet.string(from: self)
    }
    
}

extension UIView {
    
    func createBorderDashLine(color: UIColor, cornerRadius: CGFloat) {
        let border = CAShapeLayer()
        border.strokeColor = color.cgColor
        border.lineDashPattern = [5, 5]
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(border)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

extension Optional {
    
    func optionalValue() -> String {
        switch(self) {
        case .none:
            return ""
        case .some(let value):
            return value as! String
        }
    }
}

extension Double {
    
    func formatTrailing() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIImageView {
    
    func setImageOnView(_ imageUrlStr: String?,_ placeHolderImage: UIImage = AppConfig.placeHolder) {
        if let imageStr = imageUrlStr, !imageStr.isEmpty, let imageUrl = URL(string: imageStr.replacingOccurrences(of: " ", with: "%20")) {
            self.sd_setImage(with:imageUrl, placeholderImage: placeHolderImage, options: SDWebImageOptions.init(rawValue: 0), progress: nil, completed: nil)
        } else {
            self.image = placeHolderImage
        }
    }
    
    func toBase64()  -> String {
        let imageData:NSData = image!.jpegData(compressionQuality: 0.50)! as NSData
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

extension UITableView {
    
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
}

extension Array where Element:Equatable {
    
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

extension UIButton {
    
    func setImageOnButton(_ imageUrlStr: String?,_ placeHolderImage: UIImage = AppConfig.placeHolder) {
        if let imageStr = imageUrlStr, !imageStr.isEmpty, let imageUrl = URL(string: imageStr.replacingOccurrences(of: " ", with: "%20")) {
            self.sd_setImage(with: imageUrl, for: .normal, placeholderImage: placeHolderImage, options: SDWebImageOptions.init(rawValue: 0), completed: nil)
        } else {
            self.setImage(placeHolderImage, for: .normal)
        }
    }
    
}

extension NSAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let mutableString = NSMutableAttributedString(attributedString: self)
        let foundRange = mutableString.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            mutableString.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
    
}

extension URL {
    
    func getThumbnailImage() -> UIImage? {
        let asset: AVAsset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
}

extension String {
    
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

extension UIViewController {
    
    func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge) {
        
        let focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        focusGuide.preferredFocusEnvironments = [destination]

        // Configure size to match origin view
        focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

        switch direction {
        case .bottom:
            focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .top:
            focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .left:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .right:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
        default:
            break
        }

//        return focusGuide
    }
}
