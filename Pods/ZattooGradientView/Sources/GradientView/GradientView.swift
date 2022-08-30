#if canImport(UIKit)
import UIKit

final public class GradientView: UIView {

    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    public var colors: [Any]? {
        set {
            gradientLayer.colors = newValue
        }
        
        get {
            return gradientLayer.colors
        }
    }
    
    public var locations: [NSNumber]? {
        set {
            gradientLayer.locations = newValue
        }
        
        get {
            return gradientLayer.locations
        }
    }
    
    public var startPoint: CGPoint {
        set {
            gradientLayer.startPoint = newValue
        }
        
        get {
            return gradientLayer.startPoint
        }
    }
    
    public var endPoint: CGPoint {
        set {
            gradientLayer.endPoint = newValue
        }
        
        get {
            return gradientLayer.endPoint
        }
    }

    public var shouldPassthrough = false
    
    public func setDirection(startingAt startPoint: CGPoint, endingAt endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard shouldPassthrough else { return view }
        return view == self ? nil : view
    }
    
    // MARK: - Private
    
    private lazy var gradientLayer: CAGradientLayer = {
        return self.layer as! CAGradientLayer
    }()
}
#endif
