import UIKit
import SnapKit
import Foundation

class ViewTool {
  static func generateLine(_ background: UIColor? = PrimasColor.shared.main.line_background_color, _ height: CGFloat? = 1.0) -> UIView {
    let _view = UIView()
    _view.backgroundColor = background!
    _view.snp.makeConstraints {
      make in
      make.size.height.equalTo(height!)
    }
    return _view
  }
}
