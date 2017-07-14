import UIKit
import Foundation

extension Int {
  func toHumanString() -> String {
    if self >= 10000 {
      return (NSString(format: "%.1f", CGFloat(self) / 10000.0) as String) + "w"
    } else if self >= 1000 {
      return (NSString(format: "%.1f", CGFloat(self) / 1000.0) as String) + "k"
    }

    return String(describing: self)
  }
}

extension UIImage {
  static func imageWithColor(color: UIColor, width: CGFloat? = SCREEN_WIDTH, height: CGFloat? = 0.5) -> UIImage {
    let pixelScale = UIScreen.main.scale
    let pixelSize = height! / pixelScale
    let fillSize = CGSize(width: pixelSize, height: pixelSize)
    let fillRect = CGRect(origin: CGPoint.zero, size: fillSize)
    UIGraphicsBeginImageContextWithOptions(fillRect.size, false, pixelScale)
    let graphicsContext = UIGraphicsGetCurrentContext()
    graphicsContext!.setFillColor(color.cgColor)
    graphicsContext!.fill(fillRect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
}
