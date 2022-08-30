#if canImport(UIKit)
import UIKit

extension GradientView {

    public func applyGradient(_ gradient: Gradient) {
        startPoint = gradient.startPoint
        endPoint = gradient.endPoint
        colors = [gradient.startColor.cgColor, gradient.endColor.cgColor]
    }
}
#endif
