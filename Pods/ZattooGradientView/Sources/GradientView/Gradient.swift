#if canImport(UIKit)
import UIKit

@objcMembers
final public class Gradient: NSObject {

    public let startColor: UIColor
    public let endColor: UIColor
    public let startPoint: CGPoint
    public let endPoint: CGPoint

    public init(startColor: UIColor, endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        self.startColor = startColor
        self.endColor = endColor
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    public func asColor(forWidth width: CGFloat, height: CGFloat) -> UIColor? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)

        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard image != nil else { return nil }
        return UIColor(patternImage: image!)
    }
}
#endif
