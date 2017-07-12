import UIKit
import Foundation

extension Int {
  func toHumanString() -> String {
    if self >= 10000 {
      return String(describing: CGFloat(self) / 10000.0) + "w"
    } else if self >= 1000 {
      return String(describing: CGFloat(self) / 1000.0) + "k"
    }

    return String(describing: self)
  }
}
