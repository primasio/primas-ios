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

extension UIImageView {
    func afterDownloadResize(image: UIImage) {
    let imageRatio = image.size.width / image.size.height
    let viewRatio = self.frame.size.width / self.frame.size.height
    
    if imageRatio < viewRatio {
      let scale = self.frame.size.height / image.size.height
      let width = scale * image.size.width 
      let height = width / imageRatio
      self.frame.size = CGSize(width: width, height: height)
    } else {
      let scale = self.frame.size.width / image.size.width
      let height = scale * image.size.height
      let width = height * imageRatio
      self.frame.size = CGSize(width: width, height: height)
    }
  }
}
