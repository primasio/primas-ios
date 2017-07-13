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
